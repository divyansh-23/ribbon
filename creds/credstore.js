#!/usr/bin/env node
/* vim: set filetype=javascript : */

if (process.env.UMD_AH_CRED_TABLE == null) {
    console.error('No credstore specified');
    process.exit(-1);
}

if (process.argv[2] == null) {
    console.error('No credential key specified');
    process.exit(-1);
}

let credstoreTable = process.env.UMD_AH_CRED_TABLE;

let async = require ('async');

const { DynamoDBDocument } = require("@aws-sdk/lib-dynamodb");
const { DynamoDB } = require("@aws-sdk/client-dynamodb");
const { KMS } = require("@aws-sdk/client-kms");

const kms = new KMS({ region: "us-east-1" });
const ddb = DynamoDBDocument.from(new DynamoDB({ region: "us-east-1" }));

const { StringDecoder } = require('string_decoder');
const stringDecoder = new StringDecoder('ascii');

let secrets = [
    { key: process.argv[2] }
];

let productKey = process.env.UMD_AH_PRODUCTSUITE + '-' + process.env.UMD_AH_PRODUCT;

function getCredential (credential, callback)
{
    return async.waterfall ([
        (wf_cb) => {
            return ddb.get ({
                'TableName': credstoreTable,
                'Key': {
                    'ProductId': productKey,
                    'CredentialKey': credential.key,
                },
            }, (err, result) => {
                if ( err ) {
                    return wf_cb (err);
                }
                return wf_cb (null, result.Item.EncryptedCredential);
            });
        },

        (encryptedCredential, wf_cb) => {
            /* credential store app base64 encodes after encryption. */
            let encryptedBuf = Buffer.from(encryptedCredential, 'base64');
            let eContext = {
                'Environment':   process.env.UMD_AH_ENVIRONMENT,
                'CredentialKey': credential.key,
                'ProductSuite':  process.env.UMD_AH_PRODUCTSUITE,
                'Product':       process.env.UMD_AH_PRODUCT,
            };

            return kms.decrypt ({
                'CiphertextBlob':    encryptedBuf,
                'EncryptionContext': eContext,
            }, (err, result) => {
                if ( err ) {
                    return wf_cb (err);
                }

                //console.log (JSON.stringify (result, null, 4));
                const { Plaintext } = result;
                console.log( stringDecoder.write(Plaintext) );
                return wf_cb (null);
            });
        },

    ], callback);
};

async.each (secrets, getCredential, (err) => {
    if (err != null) {
        console.error(err);
        process.exit(-1);
    }
    else {
        process.exit(0);
    }
});
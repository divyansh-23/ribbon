// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/extras/dataTables.responsive
//= require dataTables/jquery.dataTables
//= require jquery.csv.js
//= require select2
//= require jquery.slicknav.js
//= require google_analytics.js.coffee



function ready(){
    $("#menu").slicknav({
        prependTo:'.slicknav',
        label: "",
        duration: 50,
        width: "resolve"
    });

    $('.datatable').DataTable({
        responsive: true,
        autoWidth: false,
        pageLength: 100,
        "aoColumnDefs": [
            { 'bSortable': false, 'aTargets': [ -1 ] }
        ]
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);

function css_safe(name) {
    return name.replace(/[^a-z0-9]/g, function(s) {
        var c = s.charCodeAt(0);
        if (c == 32) return '-';
        if (c >= 65 && c <= 90) return '_' + s.toLowerCase();
        return '__' + ('000' + c.toString(16)).slice(-4);
    });
}

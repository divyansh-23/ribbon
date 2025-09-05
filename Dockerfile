FROM ruby:2.6.10

# Add NodeSource repository to get latest nodejs
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -

# Install apt based dependencies required to run Rails as 
# well as RubyGems. As the Ruby image itself is based on a 
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \ 
  build-essential \ 
  nodejs \
  libpq-dev

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.
RUN mkdir -p /app 
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files 
# are made.
COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler -v 2.3.13 && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . ./

# Do npm build
RUN npm install

# Make sure startup scripts are executable
RUN chmod +rx bin/setenv
RUN chmod +rx creds/credstore.js

# Expose port 8080 to the Docker host, so we can access it 
# from the outside.
EXPOSE 8080

# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8080"]
ENTRYPOINT ["bin/setenv"]
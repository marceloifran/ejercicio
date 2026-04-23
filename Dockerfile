# Use official Ruby image
FROM ruby:3.2-slim

# Install dependencies for building gems
RUN apt-get update -qq && apt-get install -y build-essential

# Set work directory
WORKDIR /app

# Install gems
COPY Gemfile ./
RUN bundle install

# Copy project files
COPY . .

# Expose the port Sinatra runs on
EXPOSE 4567

# Command to run the application using Puma
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]

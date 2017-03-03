# README

[![Build Status](https://travis-ci.org/alagoasdevday/certificates.svg?branch=master)](https://travis-ci.org/alagoasdevday/certificates)
[![Test Coverage](https://codeclimate.com/github/alagoasdevday/certificates/badges/coverage.svg)](https://codeclimate.com/github/alagoasdevday/certificates/coverage)
[![Code Climate](https://codeclimate.com/github/alagoasdevday/certificates/badges/gpa.svg)](https://codeclimate.com/github/alagoasdevday/certificates)
[![Security](https://hakiri.io/github/alagoasdevday/certificates/master.svg)](https://hakiri.io/github/alagoasdevday/certificates/master)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/e998c32fd45a4c70bd8f3068ecfd137b)](https://www.codacy.com/app/gmmcal/certificates?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=alagoasdevday/certificates&amp;utm_campaign=Badge_Grade)
[![Codacy Badge](https://api.codacy.com/project/badge/Coverage/e998c32fd45a4c70bd8f3068ecfd137b)](https://www.codacy.com/app/gmmcal/certificates?utm_source=github.com&utm_medium=referral&utm_content=alagoasdevday/certificates&utm_campaign=Badge_Coverage)

Certificates app for Alagoas Dev Day

# Requirements

This app was built using ruby 2.4.x and Postgresql. This app is currently built with portuguese texts. This may be updated in the future.

# Installing

After cloning this app, run the following commands:

If you use RVM, make sure you have ruby 2.4.x installed. If so, when in the app folder, run (change .x for the minor version of your ruby. I.E.: 2.4.0)

```
rvm rvmrc create ruby-2.4.x@certificatesapp --ruby-version
rvm use ruby-2.4.x@certificatesapp
bundle install
cp config/database-example.yml config/database.yml
-- (Config your database parameter on database.yml (if needed))
cp config/secrets-example.yml config/secrets.yml
rake db:create
rake db:migrate
```

Your app should be ready to run. There's no data seed or admin views. In order to add data to your database, you should create Event and Participant objects on your console. To do this, just run the following commands:


```
rails console
Event.create(name: "Event Name", location: "Event Place", start_date: Date.today, end_date: Date.today, workload: 8)
participant = Participant.create(name: "John Doe", email: "john@example.com", participation_type: "Listener")
participant.events << Event.first
exit
rails server
```

The go to your browser and load ```localhost:3000``` and search for ```john@example.com```. You should see the data you filled on console.

To run the tests, just run ```rspec spec``` on your console.

# Contributing

Please, check [Contributing](https://github.com/alagoasdevday/certificates/blob/master/CONTRIBUTING.md)

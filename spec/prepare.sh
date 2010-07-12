#!/bin/bash

cd testapp && bundle install && rake -R ../../tasks ichiban:initialize && echo 'gem "ichiban", :path => "../../"' >> Gemfile


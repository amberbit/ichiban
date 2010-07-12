#!/bin/bash

cd testapp && rake -R ../../tasks ichiban:initialize && echo 'gem "ichiban", :path => "../../"' >> Gemfile


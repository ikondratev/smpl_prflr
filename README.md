# SMPL_PRFLR
**smpl_prflr** - Profiler your owc code.

## Dependencies:
```sh
ruby '2.7.2'
gem 'redis' '~> 4.6'
gem 'ruby-prof' '~>1.4'
gem 'rack'
```
## Install:
```sh
bundle install smpl_prflr

requre 'smpl_prflr'
```
## As web:
```sh
gem install smpl_prflr

smpl_prflr
```
## How is it works?:
```sh
 require 'smpl_prflr'
 
 SmplPrflr.new.p(prof: "") do
   'your own code'
 end
 
 after that you should start web server smpl_prflr
 get request: 127.0.0.1:9292/
 
```
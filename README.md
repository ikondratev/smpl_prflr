# SMPL_PRFLR
**smpl_prflr** - Profiler your owc code.

## Dependencies:
```sh
ruby '2.7.2'
...
gem 'redis' '4.6'
gem 'ruby-prof' '1.4'
gem 'rubocop' '1.26'
gem 'rack' '2.2'
```
## Install:
```sh
bundle install smpl_prflr

requre 'smpl_prflr'

```
## How is it works?:
```sh
 require 'smpl_prflr'

 include SmplPrflr 

 initialize_profiler! :production
 
 p { block_of_your_own_code }
```

## As web:
```sh
 user@mac$ gem install smpl_prflr
 ...
 user@mac$ smpl_prflr
 ... 
 get request: 127.0.0.1:9292/
```
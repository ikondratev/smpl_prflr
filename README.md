# SMPL_PRFLR
**smpl_prflr** - Profiler your owc code.

## Dependencies:
```sh
ruby '2.7.2'
gem 'redis' '~> 4.6'
gem 'ruby-prof' '~>1.4'
```
## Install:
```sh
bundle install smpl_prflr

requre 'smpl_prflr'
```
## How is it works?:
```sh
 require 'smpl_prflr'
 
 profiler = SmplPrflr.new
 
 profiler.profile do
   'your own code'
 end
```
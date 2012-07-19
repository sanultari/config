# SanUltari Configuration
[![Gemnasium](https://gemnasium.com/sanultari/config.png)](https://gemnasium.com/sanultari/config)
오브젝트를 이용하여 계층형 설정 정보를 관리하기 위한 라이브러리.

## 사용방식
```ruby
require 'sanultari-config'
config = SanUltari::Config.new
config.init!
config.develop.db.type = 'mysql'
config.develop.db.host = 'localhost'
config.develop.db.port = ...
config.production.db.type = 'postgresql'
config.production.db.host = 'localhost'
```
## Contributing to sanultari-config 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright
Copyright (c) 2012 Team SanUltari. See LICENSE.txt for further details.
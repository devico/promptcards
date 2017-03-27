name            'psql_db'
maintainer      'devico'
maintainer_email 'clamdm@mail.ru'
license 'All rights reserved'
description 'Create user and databases for app'
chef_version '>= 11.0' if respond_to?(:chef_version)
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

depends 'postgresql'
depends 'database'

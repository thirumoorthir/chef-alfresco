name             "alfresco"
maintainer       "Maurizio Pillitu"
maintainer_email ""
license          "Apache 2.0"
description      "Installs Alfresco Community and Enterprise Edition."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url ""
source_url ""
version "0.7.13"

# Resolved by Berkshelf, not present in Supermarket or forked
depends "file"
depends "tomcat"
depends "maven"
depends "commons"

# Community cookbooks
depends "activemq", ">= 1.3.3"
depends "artifact-deployer", ">= 0.8.18"
depends 'build-essential', ">= 2.2.3"
depends "database", ">= 4.0.6"
depends "ffmpeg", ">= 0.4.4"
depends "haproxy", "~> 1.6.6"
depends "imagemagick", ">= 0.2.3"
depends "java", ">= 1.31.0"
depends "libreoffice", ">= 0.0.2"
depends 'line', '>= 0.6.2'
depends "logstash-forwarder", '>= 0.1.1'
depends 'mysql', '~> 7.2'
depends 'mysql2_chef_gem', ">= 1.0.1"
depends "nginx", ">= 2.7.6"
depends "openssl", ">= 4.0.0"
depends "postgresql", ">= 3.4.18"
depends 'rsyslog', ">= 1.15.0"
depends "swftools", ">= 0.2.4"
depends 'yum-epel'
depends 'yum-atrpms', ">= 0.1.0"

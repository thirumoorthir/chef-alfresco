remote_file "#{Chef::Config[:file_cache_path]}/rds-combined-ca-bundle.pem" do
  source 'http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem'
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end

execute 'split_certs' do
  command <<-EOF
    cd #{Chef::Config[:file_cache_path]}
    csplit -sz rds-combined-ca-bundle.pem '/-BEGIN CERTIFICATE-/' '{*}'
    EOF
  only_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/rds-combined-ca-bundle.pem") }
end

truststore = node['alfresco']['truststore_file']
truststore_pass = node['alfresco']['truststore_password']
truststore_type = node['alfresco']['truststore_type']

ruby_block "Import AWS RDS Certs" do
  block do
    Dir.glob("#{Chef::Config[:file_cache_path]}/xx*").each do |cert|
      cmd = Chef::ShellOut.new(
            %Q[ keytool -import -keystore #{truststore} -storepass #{truststore_pass} -storetype #{truststore_type} -noprompt \
                -alias \"$(openssl x509 -noout -text -in #{cert} | perl -ne 'next unless /Subject:/; s/.*CN=//; print')\" -file #{cert} ]
            ).run_command
    end
  end
  action :run
end

ssl_db_conf = " -Djavax.net.ssl.keyStore=#{node['alfresco']['keystore_file']} -Djavax.net.ssl.keyStorePassword=#{node['alfresco']['keystore_password']}"
node.default['alfresco']['repo_tomcat_instance']['java_options']['others'] = "#{node['alfresco']['repo_tomcat_instance']['java_options']['others']} #{ssl_db_conf}"

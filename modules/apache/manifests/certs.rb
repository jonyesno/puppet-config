hostclass :"apache::certs" do
  certs = scope.lookupvar("certs")
  certs.each do |cert|
    file "/etc/httpd/ssl/#{cert}.pem",
      :owner   => "root",
      :group   => "root",
      :source  => "puppet://puppet/apache/#{cert}.pem",
      :require => "Class[apache::directories]"
  end
end

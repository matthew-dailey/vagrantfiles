# Chef script for manually installing tar/RPM files from remote

IDEA_FILE=ideaIC-14.1.4.tar.gz

remote_file "/vagrant/#{IDEA_FILE}" do
    source "http://download.jetbrains.com/idea/#{IDEA_FILE}"
    mode 0644
    checksum '3a8dc4a12ab9f3607a1a2097bbab0150c947ad6719d8f1bb6d5b47d0fb0c4779'
end

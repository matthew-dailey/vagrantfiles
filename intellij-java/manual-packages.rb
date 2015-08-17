# Chef script for manually installing tar/RPM files from remote

IDEA_FILE = 'ideaIC-14.1.4.tar.gz'
JDK_FILE = 'jdk-8u51-linux-x64.rpm'
MAVEN_FILE = 'apache-maven-3.3.3-bin.tar.gz'

# path, url, sha2
pkgs = [
    ["/vagrant/#{IDEA_FILE}", "http://download.jetbrains.com/idea/#{IDEA_FILE}", 'bd13fdd487ff37fb8b1d6aa713a6ff2c642b8b2ed74d292a8b624ab55c1ba9fb'],
    ["/vagrant/#{JDK_FILE}", "http://download.oracle.com/otn-pub/java/jdk/8u51-b16/#{JDK_FILE}", '49527b54d8e179c8da3547fbac223e9b1ecb4b5276b47823c466617aec4bb97b'],
    ["/vagrant/#{MAVEN_FILE}", "http://mirror.reverse.net/pub/apache/maven/maven-3/3.3.3/binaries/#{MAVEN_FILE}", '3a8dc4a12ab9f3607a1a2097bbab0150c947ad6719d8f1bb6d5b47d0fb0c4779']
]

# TODO: wget needed special cookies to download the JDK.  Can we do that here?
pkgs.each do |pkg|
    path, url, sha2 = pkg
    remote_file path do
        source url
        checksum sha2
        mode 0644
    end
end

# TODO: install rpms and untar the tgz files
# TODO: add idea.sh to path

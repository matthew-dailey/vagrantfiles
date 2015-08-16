# Chef script for installing required packages

['vim', 'git', 'xorg-x11-xauth', 'libXtst', 'libXrender'].each do |p|
    package p
end

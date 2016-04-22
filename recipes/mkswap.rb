#
# Cookbook Name:: .
# Recipe:: mkswap
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

 bash 'create swapfile' do
  not_if { File.exists?('/swap.img') }
  code <<-EOC
    dd if=/dev/zero of=/swap.img bs=1M count=1024 &&
    chmod 600 /swap.img
    mkswap /swap.img
  EOC
end

mount '/dev/null' do # swap file entry for fstab
  action :enable # cannot mount; only add to fstab
  device '/swap.img'
  fstype 'swap'
end

bash 'activate swap' do
  code 'swapon -ae'
end

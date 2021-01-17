packages_req <- scan('requirements.txt', what='')
packages_to_intall <- packages_req[!packages_req %in% installed.packages()[,'Package']]

if(length(packages_to_intall)){
  install.packages(packages_to_intall)
}

sapply(packages_req, require, character.only = TRUE)
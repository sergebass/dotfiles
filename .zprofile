# reuse environment setup from .profile, if it exists
# (taken from https://superuser.com/a/398990)
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# if a job-specific configuration file exists, load it too
[[ -e ~/.workenv ]] && emulate sh -c 'source ~/.workenv'

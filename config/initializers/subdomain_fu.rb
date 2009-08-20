# the size of the top-level domain name
SubdomainFu.tld_sizes = { :development => 0, :test => 0, :production => 1 }
# mirrors are the subdomains that are equivalent to no subdomain
SubdomainFu.mirrors = %w(www) # Defaults to %w(www)
# a false subdomain goes
#SubdomainFu.preferred_mirror = "www" # subdomain can't be false in this app
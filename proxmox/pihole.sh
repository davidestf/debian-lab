#!/bin/bash


curl -sSL https://install.pi-hole.net | bash


#update
#pihole -up

#blocklist source list
#pihole -g

#reconfigure
#pihole -r 



root@raspberrypi:/home/pi# cat /etc/pihole/adlists.list
# Prevent Trackers and Malwares
https://raw.githubusercontent.com/DRSDavidSoft/additional-hosts/master/domains/blacklist/adservers-and-trackers.txt
https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt
https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt
https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt
https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt
https://gitlab.com/my-privacy-dns/matrix/matrix/-/raw/master/source/tracking/domains.list
https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardApps.txt
https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardMobileAds.txt
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/StreamingAds/hosts
https://raw.githubusercontent.com/w13d/adblockListABP-PiHole/master/Spotify.txt
https://raw.githubusercontent.com/DRSDavidSoft/additional-hosts/master/domains/blacklist/adservers-and-trackers.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/AdAway-Default-Blocklist.txt
https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
https://v.firebog.net/hosts/Easyprivacy.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/FadeMind-addSpam.txt
https://raw.githubusercontent.com/mitchellkrogza/The-Big-List-of-Hacked-Malware-Web-Sites/master/hacked-domains.list
# Prevent Analytics
https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt
https://raw.githubusercontent.com/mitchellkrogza/Stop.Google.Analytics.Ghost.Spam.HOWTO/master/output/domains/INACTIVE/list
https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/analytics.txt
https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/analyticsparsed
https://raw.githubusercontent.com/kowith337/PersonalFilterListCollection/master/hosts/hosts_facebook0.txt
https://raw.githubusercontent.com/anudeepND/blacklist/master/facebook.txt
# Prevent Spyware
https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardMobileSpyware.txt
https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/PiHole_HOSTS_Spyware.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/WindowsSpyBlocker81.txt
https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt
# Prevent Coinmining network
https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/list.txt
https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/list_browser.txt
https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/hosts
https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/hosts_optional
https://raw.githubusercontent.com/anudeepND/blacklist/master/CoinMiner.txt
https://raw.githubusercontent.com/austinheap/sophos-xg-block-lists/master/nocoin.txt
# Prevent Ransomware
https://raw.githubusercontent.com/pirat28/IHateTracker/master/iHateTracker.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/CryptoWall-Ransomware-C2-Domain-blocklist.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/Locky-Ransomware-C2-Domain-Blocklist.txt
https://raw.githubusercontent.com/XionKzn/PiHole-Lists/master/Cerber_Ransomware.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/Ransomware-Domain-Blocklist.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/TeslaCrypt-Ransomware-C2-Domain-Blocklist.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/TeslaCrypt-Ransomware-Payment-Sites-Domain-Blocklist.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/TorrentLocker-Ransomware-C2-Domain-Blocklist.txt
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/Subscribable-Lists/ParsedBlacklists/TorrentLocker-Ransomware-Payment-Sites-Domain-Blocklist.txt
# Prevent Phishing
https://gitlab.com/Kurobeats/phishing_hosts/raw/master/hosts
https://raw.githubusercontent.com/MetaMask/eth-phishing-detect/master/src/hosts.txt

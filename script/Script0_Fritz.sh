echo 'zone "marley.it14.com" {
    type master;
    file "/etc/bind/sites/marley.it14.com";
};
zone "eldia.it14.com" {
    type master;
    file "/etc/bind/sites/eldia.it14.com";
};' > /etc/bind/named.conf.local

mkdir -p /etc/bind/sites
cp /etc/bind/db.local /etc/bind/sites/marley.it14.com
cp /etc/bind/db.local /etc/bind/sites/eldia.it14.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     marley.it14.com. root.marley.it14.com. (
                        2024102301      ; Serial
                        604800         ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
@       IN      NS      marley.it14.com.
@       IN      A       192.240.1.2    ; IP Annie
www     IN      CNAME   marley.it14.com.' > /etc/bind/sites/marley.it14.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     eldia.it14.com. root.eldia.it14.com. (
                            2024102301         ; Serial
                            604800              ; Refresh
                            86400              ; Retry
                            2419200              ; Expire
                            604800 )            ; Negative Cache TTL
;
@       IN      NS      eldia.it14.com.
@       IN      A       192.240.2.2    ; IP Armin
www     IN      CNAME   eldia.it14.com.' > /etc/bind/sites/eldia.it14.com

echo 'options {
    directory "/var/cache/bind";

    forwarders {
        192.168.122.1;
    };

    // dnssec-validation auto;

    allow-query { any; };
    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

service bind9 restart

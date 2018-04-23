//Firefox Default Settings
//set proxy server settings
pref("network.proxy.http", "172.17.0.1");
pref("network.proxy.http_port", 3128);
pref("network.proxy.ssl", "172.17.0.1");
pref("network.proxy.ssl_port", 3128);
pref("network.proxy.no_proxies_on", "*.local, 10.*, 150.*, 127.0.0.1");
pref("network.proxy.type", 1);
pref("network.proxy.share_proxy_settings", true); // use the same proxy settings for all protocols
pref("accept_untrusted_certs", true);
pref("webdriver_accept_untrusted_certs", true);
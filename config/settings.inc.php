<?php
if(in_array($_SERVER['SERVER_NAME'], array('www.monpotpourri.com', 'monpotpourri.com'))) {
    define('_DB_SERVER_', 'monpotposi74.mysql.db');
    define('_DB_NAME_', 'monpotposi74');
    define('_DB_USER_', 'monpotposi74');
    define('_DB_PASSWD_', 'rq0uVEZZRCLL');
} else {
    define('_DB_SERVER_', 'localhost');
    define('_DB_NAME_', 'potpourri');
    define('_DB_USER_', 'root');
    define('_DB_PASSWD_', 'root');
}
define('_DB_PREFIX_', 'ps_');
define('_MYSQL_ENGINE_', 'InnoDB');
define('_PS_CACHING_SYSTEM_', 'CacheFs');
define('_PS_CACHE_ENABLED_', '0');
define('_COOKIE_KEY_', 'AQmtaj2v0z2PDaLYXA0px54ROFWgqssNN34RHegc3i8CnLdomp5toNk1');
define('_COOKIE_IV_', 'XmRc4J4I');
define('_PS_CREATION_DATE_', '2016-10-16');
define('_PS_VERSION_', '1.6.1.15');
define('_RIJNDAEL_KEY_', 'mVcoO4f89irWV9LtU2tCjEme4RaTPYbk');
define('_RIJNDAEL_IV_', 'yUYx8qJMmz97Ib6NosA2GQ==');
define('_PS_DIRECTORY_', '/../../');

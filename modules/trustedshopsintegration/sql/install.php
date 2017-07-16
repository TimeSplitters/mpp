<?php
/**
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2017 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

$sql = array();

$sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'trustedshopsintegration` (
  `id_ts_config` int(11) NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `id_trusted_shops` varchar(40) NOT NULL,
  `current_mode` varchar(32) NOT NULL,
  `variant` varchar(32) NOT NULL,
  `y_offset` int(11) NOT NULL,
  `collect_reviews` tinyint(1) NOT NULL,
  `show_reviews` tinyint(1) NOT NULL,
  `show_rating` tinyint(1) NOT NULL,
  `review_tab_name` varchar(50) NOT NULL,
  `review_tab_border_color` varchar(7) NOT NULL,
  `review_tab_star_color` varchar(7) NOT NULL,
  `review_tab_background_color` varchar(7) NOT NULL,
  `hide_empty_reviews` int(11) NOT NULL,
  `rating_star_color` varchar(7) NOT NULL,
  `rating_star_size` double NOT NULL,
  `rating_font_size` double NOT NULL,
  `hide_empty_ratings` tinyint(1) NOT NULL,
  `trustbadge_code` text NOT NULL,
  `product_sticker_code` text NOT NULL,
  `product_widget_code` text NOT NULL,
  `gtin_allocation` varchar(32) NOT NULL,
  `brand_allocation` varchar(32) NOT NULL,
  `mpn_allocation` varchar(32) NOT NULL,
  PRIMARY KEY (`id_ts_config`),
  UNIQUE KEY `id_trusted_shops` (`id_trusted_shops`)
) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;';

foreach ($sql as $query) {
    if (Db::getInstance()->execute($query) == false) {
        return false;
    }
}

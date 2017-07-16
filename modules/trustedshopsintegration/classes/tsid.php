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

class TSID extends ObjectModel
{
    public $id_ts_config;
    public $id_shop;
    public $id_lang;
    public $id_trusted_shops;
    public $current_mode;
    public $variant;
    public $y_offset;
    public $collect_reviews;
    public $show_reviews;
    public $show_rating;
    public $review_tab_name;
    public $review_tab_border_color;
    public $review_tab_star_color;
    public $review_tab_background_color;
    public $hide_empty_reviews;
    public $rating_star_color;
    public $rating_star_size;
    public $rating_font_size;
    public $hide_empty_ratings;
    public $trustbadge_code;
    public $product_sticker_code;
    public $product_widget_code;
    public $gtin_allocation;
    public $brand_allocation;
    public $mpn_allocation;


    public static $definition = array(
        'table' => 'trustedshopsintegration',
        'primary' => 'id_ts_config',
        'fields' => array(
          'id_ts_config' => array('type' => self::TYPE_INT, 'required' => false),
          'id_shop' => array('type' => self::TYPE_INT, 'required' => true),
          'id_lang' => array('type' => self::TYPE_INT, 'required' => true),
          'id_trusted_shops' => array('type' => self::TYPE_STRING, 'required' => true),
          'current_mode' => array('type' => self::TYPE_STRING, 'required' => false),
          'variant' => array('type' => self::TYPE_STRING, 'required' => false),
          'y_offset' => array('type' => self::TYPE_INT, 'required' => false),
          'collect_reviews' => array('type' => self::TYPE_INT, 'required' => false),
          'show_reviews' => array('type' => self::TYPE_INT, 'required' => false),
          'show_rating' => array('type' => self::TYPE_INT, 'required' => false),
          'review_tab_name' => array('type' => self::TYPE_STRING, 'required' => false),
          'review_tab_border_color' => array('type' => self::TYPE_STRING, 'required' => false),
          'review_tab_star_color' => array('type' => self::TYPE_STRING, 'required' => false),
          'review_tab_background_color' => array('type' => self::TYPE_STRING, 'required' => false),
          'hide_empty_reviews' => array('type' => self::TYPE_INT, 'required' => false),
          'rating_star_color' => array('type' => self::TYPE_STRING, 'required' => false),
          'rating_star_size' => array('type' => self::TYPE_INT, 'required' => false),
          'rating_font_size' => array('type' => self::TYPE_INT, 'required' => false),
          'hide_empty_ratings' => array('type' => self::TYPE_INT, 'required' => false),
          'trustbadge_code' => array('type' => self::TYPE_HTML, 'required' => false),
          'product_sticker_code' => array('type' => self::TYPE_HTML, 'required' => false),
          'product_widget_code' => array('type' => self::TYPE_HTML, 'required' => false),
          'gtin_allocation' => array('type' => self::TYPE_STRING, 'required' => false),
          'brand_allocation' => array('type' => self::TYPE_STRING, 'required' => false),
          'mpn_allocation' => array('type' => self::TYPE_STRING, 'required' => false)
        ),
    );
}

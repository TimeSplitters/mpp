{*
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
*}
<div id="ts_product_widget">
</div>
<script type="text/javascript" src="//widgets.trustedshops.com/reviews/tsSticker/tsProductStickerSummary.js"></script>
<script type="text/javascript">
    var summaryBadge = new productStickerSummary();
    summaryBadge.showSummary({
    'tsId': '{$id_trusted_shops|escape:'htmlall':'UTF-8'}',
    'sku': ['{$ts_product_sku|escape:'htmlall':'UTF-8'}'],
    'element': '#ts_product_widget',
    'starColor' : '{$rating_star_color|escape:'htmlall':'UTF-8'}',
    'starSize' : '{$rating_star_size|escape:'htmlall':'UTF-8'}px',
    'fontSize' : '{$rating_font_size|escape:'htmlall':'UTF-8'}px',
    {if $show_rating == 1}
        'showRating' : 'true',
    {else}
        'showRating' : 'false',
    {/if}
    'scrollToReviews' : 'false',
    {if $hide_empty_ratings == 1}
        'enablePlaceholder': 'false'
    {else}
        'enablePlaceholder': 'true'
    {/if}
});
</script>
<script>
    jQuery(document).ready(function() {
        $('#ts_product_widget').insertAfter('h1[itemprop="name"]');
    });
</script>

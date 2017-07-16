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

{if $review_tab_name != ''}
    <h3 id="ts_headline" class="page-product-heading">{$review_tab_name|escape:'htmlall':'UTF-8'}</h3>
{/if}
<div id="ts_product_sticker">
</div>
<script type="text/javascript">
    _tsProductReviewsConfig = {
        'tsid': '{$id_trusted_shops|escape:'htmlall':'UTF-8'}',
        'sku': ['{$ts_product_sku|escape:'htmlall':'UTF-8'}'],
        'locale': '{$locale|escape:'htmlall':'UTF-8'}',
        {foreach key=skey item=sval from=$product_sticker_config}
            '{$skey|escape:'htmlall':'UTF-8'}' : '{$sval|escape:'htmlall':'UTF-8'}',
        {/foreach}
        'element': '#ts_product_sticker'
    };
    var scripts = document.getElementsByTagName('SCRIPT'),
    me = scripts[scripts.length - 1];
    var _ts = document.createElement('SCRIPT');
    _ts.type = 'text/javascript';
    _ts.async = true;
    _ts.charset = 'utf-8';
    _ts.src ='//widgets.trustedshops.com/reviews/tsSticker/tsProductSticker.js';
    me.parentNode.insertBefore(_ts, me);
    _tsProductReviewsConfig.script = _ts;
</script>

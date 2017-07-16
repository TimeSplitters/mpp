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
    <script type="text/javascript">
        (function () {
        var _tsid = '{$id_trusted_shops|escape:'htmlall':'UTF-8'}';
            _tsConfig = {
            /* offset from page bottom */
            'yOffset': '{$y_offset|escape:'htmlall':'UTF-8'}',
            /* default, reviews, custom, custom_reviews */
            {if $variant == 'hide'}
                'variant': 'default',
            {else}
                'variant': '{$variant|escape:'htmlall':'UTF-8'}',
            {/if}
            /* required for variants custom and custom_reviews */
            'customElementId': '',
            /* for custom variants: topRight, topLeft, bottomRight, bottomLeft */
            'trustcardDirection': '',
            /* for custom variants: 40 - 90 (in pixels) */
            'customBadgeWidth': '',
            /* for custom variants: 40 - 90 (in pixels) */
            'customBadgeHeight': '',
            /* deactivate responsive behaviour */
            'disableResponsive': 'false',
            /* deactivate trustbadge */
            {if $variant == 'hide'}
                'disableTrustbadge': 'true'
            {else}
                'disableTrustbadge': 'false'
            {/if}
            };
            var _ts = document.createElement('script');
            _ts.type = 'text/javascript';
            _ts.charset = 'utf-8';
            _ts.async = true;
            _ts.src = '//widgets.trustedshops.com/js/' + _tsid + '.js';
            var __ts = document.getElementsByTagName('script')[0];
            __ts.parentNode.insertBefore(_ts, __ts);
        })();
    </script>

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

{if $collect_reviews == '1'}
    <div id="collect_review_settings">
{else}
    <div id="collect_review_settings" style="display: none;">
{/if}
        <div class="row">
            <div class="col-lg-3">
            </div>
            <div class="col-lg-9">
                <h4>{l s='Additional Product Attributes' mod='trustedshopsintegration'}</h4>
                <p>{l s='These attributes for Product Reviews are optional and not integrated within PrestaShop standard.' mod='trustedshopsintegration'}<br />
                {l s='You can choose from the product attributes which you have manually added to fill these fields.' mod='trustedshopsintegration'} <br />
                {l s='In this way you can use Google Shopping or improve your data analysis possibilities.' mod='trustedshopsintegration'}
                </p>
            </div>
        </div>
        {*
        <div class="form-group">
            <label class="control-label col-lg-3">{l s='GTIN' mod='trustedshopsintegration'}</label>
            <div class="col-lg-9">
                <button data-tooltip="{l s='This is the product identification code for trade items. If you use Google Shopping and want to display your review stars in Shopping and payed product ads, this information is necessary for Google. It also helps in matching your products.Trusted Shops highly recommends to use this option.' mod='trustedshopsintegration'}" class="help pull-left">?</button>
                <select id="gtin" name="gtin_allocation" class="fixed-width-xxl">
                        {foreach from=$gtinAllocations key=k item=i}
                            <option {if $gtin_allocation == $k}selected{/if} value="{$k|escape:'htmlall':'UTF-8'}">{$i|escape:'htmlall':'UTF-8'}</option>
                        {/foreach}
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-lg-3">{l s='Brand' mod='trustedshopsintegration'}</label>
            <div class="col-lg-9">
                <button data-tooltip="{l s='This is the brand name of the product. By setting this variable you can improve your data analysis possibilities' mod='trustedshopsintegration'}" class="help pull-left">?</button>
                <select id="brand" name="brand_allocation" class="fixed-width-xxl">
                    {foreach from=$brandAllocations key=k item=i}
                        <option {if $brand_allocation == $k}selected{/if} value="{$k|escape:'htmlall':'UTF-8'}">{$i|escape:'htmlall':'UTF-8'}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        *}
        <div class="form-group">
            <label class="control-label col-lg-3">{l s='MPN' mod='trustedshopsintegration'}</label>
            <div class="col-lg-9">
                <div class="tooltip-ts pull-left"><button class="help">?</button><span class="tooltiptext">
                        {l s='Number that ssociates the product to its manufacturer.' mod='trustedshopsintegration'}
                </span></div>
                <select id="mpn" name="mpn_allocation" class="fixed-width-xxl">
                    {foreach from=$mpnAllocations key=k item=i}
                        <option {if $mpn_allocation == $k}selected{/if} value="{$k|escape:'htmlall':'UTF-8'}">{$i|escape:'htmlall':'UTF-8'}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    </div>

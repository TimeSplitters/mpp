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

<div class="panel">
    <div id="ts_info">
        <div class="row text-center">
            <img class="img-responsive center-block" src="{$module_dir|escape:'htmlall':'UTF-8'}trustedshopsintegration/views/img/infimg_{$iso_lang|escape:'htmlall':'UTF-8'}.jpg" />
            <a id="overlay-image" class="img-responsive center-block" target="_blank" href="{$registration_link|escape:'htmlall':'UTF-8'}"></a>
        </div>
        <div class="row text-center">
            <a target="_blank" href="{$registration_link|escape:'htmlall':'UTF-8'}" target="_blank" class="btn btn-primary">{l s='Get your account' mod='trustedshopsintegration'}</a>
        </div>
    </div>
</div>

<div id="ts_overview" class="panel">
    <div class="row">
        <div class="col-md-12">
            <form id="add_ts" action="{$actionURL|escape:'htmlall':'UTF-8'}" class="defaultForm form-horizontal" method="post">
                <div class="form-wrapper">
                    <label class="control-label col-lg-4">
                        {l s='New Trusted Shops ID' mod='trustedshopsintegration'}
                    </label>
                    <div class="col-lg-8">
                        <div class="tooltip-ts pull-left"><button class="help">?</button><span class="tooltiptext">
                                {l s='The Trusted Shops ID is a unique identifier for your shop. You can find your Trusted Shops ID in your confirmation email after signing up.' mod='trustedshopsintegration'}
                        </span></div>
                        <input class="form-control fixed-width-xxl pull-left" placeholder="{l s='Enter Trusted Shops ID...' mod='trustedshopsintegration'}" name="id_trusted_shops" type="text" />
                        <select class="form-control fixed-width-lg pull-left" name="id_lang">
                                <option value="0">{l s='Choose Language' mod='trustedshopsintegration'}</option>
                                {foreach from=$languages key=k item=i}
                                    <option value="{$i.id_lang|escape:'htmlall':'UTF-8'}">{$i.name|escape:'htmlall':'UTF-8'}</option>
                                {/foreach}
                        </select>
                        <input class="btn btn-default pull-left" value="{l s='Save' mod='trustedshopsintegration'}" type="submit" name="addTSConfig" />
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
{* HTML CONTENT / No escaping *}
{$ts_config_list}
<!-- Require TS ID and Lang ID -->
<script type="text/javascript">
    $(document).ready(function() {
        $('#add_ts').submit(function(event) {
            error = false;
            if($('select[name="id_lang"]').val() == 0) {
                error = true;
            }
            id_trusted_shops = $('input[name="id_trusted_shops"]').val();
            if(id_trusted_shops.length < 32) {
                error = true;
            }
            console.log(error);
            if(error == false) {
                return true;
            }
            return false;
        });
    });
</script>

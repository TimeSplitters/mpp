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

<div id="ts_wrapper">
    <form id="module_form" class="defaultForm form-horizontal" action="" method="post">
        <div id="fieldset_0" class="panel">
            <div class="panel-heading">
                <i class="icon-tags"></i> {$fieldtranslation.info_tab_1|escape:'htmlall':'UTF-8'}
            </div>
            <div class="form-wrapper">
                <div class="form-group">
                    <div class="control-label col-lg-3">
                        {$fieldtranslation.id_trusted_shops|escape:'htmlall':'UTF-8'}
                    </div>
                    <div class="ts-val col-lg-9">
                        <strong>{$id_trusted_shops|escape:'htmlall':'UTF-8'}</strong>
                        <a href="index.php?controller=AdminModules&amp;configure=trustedshopsintegration&amp;id_ts_config={$id_ts_config|escape:'htmlall':'UTF-8'}&amp;deletetrustedshopsintegration_configs&amp;token={$token|escape:'htmlall':'UTF-8'}" onclick="if (confirm('{$fieldtranslation.delete_alert|escape:'htmlall':'UTF-8'}'))
                        {literal}
                            {return true;}else{event.stopPropagation(); event.preventDefault();};"
                        {/literal} class="delete"><i class="icon-trash"></i></a>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-3">{$fieldtranslation.current_mode|escape:'htmlall':'UTF-8'}</label>
                    <div class="col-lg-9">
                        <div class="tooltip-ts pull-left"><button class="help">?</button><span class="tooltiptext">
                                {$fieldtranslation.current_mode_tooltip|escape:'htmlall':'UTF-8'}
                        </span></div>
                        <select id="current_mode" name="current_mode" class="fixed-width-xxl">
                            <option {if $current_mode=='standard' }selected{/if} value="standard">{l s='Standard' mod='trustedshopsintegration'}</option>
                            <option {if $current_mode=='expert' }selected{/if} value="expert">{l s='Expert' mod='trustedshopsintegration'}</option>
                        </select>
                    </div>
                </div>
            </div>
                <p>{l s='Use additional options to customize your Trusted Shops Integration or use the latest code version here. E.g.:' mod='trustedshopsintegration'}</p>
                <ul class="list">
                    <li>{l s='Place your Trustbadge wherever you want' mod='trustedshopsintegration'}</li>
                    <li>{l s='Deactivate mobile use' mod='trustedshopsintegration'}</li>
                    <li>{l s='Jump from your Product Review stars directly to your Product Reviews' mod='trustedshopsintegration'}</li>
                </ul>
                <p>
                    {l s='Learn more about' mod='trustedshopsintegration'} <a href="{$trustbadge_options_link|escape:'htmlall':'UTF-8'}" target="_blank">{l s='Trustbadge options' mod='trustedshopsintegration'}</a> {l s='and' mod='trustedshopsintegration'} <a href="{$product_review_information_link|escape:'htmlall':'UTF-8'|escape:'htmlall':'UTF-8'}" target="_blank">{l s='Product Reviews configuration' mod='trustedshopsintegration'}</a>
                    {l s='or' mod='trustedshopsintegration'} <a href="{$trusted_test_link|escape:'htmlall':'UTF-8'}" target="_blank">{l s='test' mod='trustedshopsintegration'}</a> {l s='your configuration options and copy your code directly.' mod='trustedshopsintegration'}
                </p>
        </div>
        <div class="panel" id="fieldset_1">
            <div class="panel-heading">
                <i class="icon-tags"></i> {$fieldtranslation.info_tab_2|escape:'htmlall':'UTF-8'}
            </div>
            <div class="form-wrapper" style="overflow: hidden;">
                <div class="col-lg-3"></div>
                <div class="col-lg-9">
                    <textarea class="form-control resizable-vertical" rows="5" name="trustbadge_code" id="trustbadge_code">{$trustbadge_code|escape:'htmlall':'UTF-8'}</textarea>
                    <p class="help-block">{$fieldtranslation.trustbadge_code|escape:'htmlall':'UTF-8'}</p>
                </div>
            </div>
        </div>
        <div class="panel" id="fieldset_2">
            <div class="panel-heading">
                <i class="icon-tags"></i> {$fieldtranslation.info_tab_3|escape:'htmlall':'UTF-8'}
            </div>
            <div class="form-wrapper">
                <div class="form-group">
                    <div class="control-label col-lg-3"></div>
                    <label class="control-label col-lg-3 checkbox">
                        <input id="collect_reviews" {if $collect_reviews=='1' }checked{/if} value="1" type="checkbox" name="collect_reviews" /> {$fieldtranslation.collect_reviews|escape:'htmlall':'UTF-8'}
                    </label>
                </div>
                {* HTML/JS Content / No escaping *}
                {$ts_info_hint}
                {* HTML/JS Content / No escaping *}
                {$additional_product_attributes}
                {if $collect_reviews == '1'}
                    <div id="show_reviews_wrapper" style="overflow: hidden;">
                {else}
                    <div id="show_reviews_wrapper" style="display: none">
                {/if}
                    <hr class="divide" />
                    <div class="form-group">
                        <div class="control-label col-lg-3"></div>
                        <label class="control-label col-lg-3 checkbox">
                            <input id="show_reviews" {if $show_reviews=='1' }checked{/if} value="1" type="checkbox" name="show_reviews" /> {$fieldtranslation.show_reviews|escape:'htmlall':'UTF-8'}
                        </label>
                    </div>
                    {if $show_reviews == 1}
                        <div id="product_sticker_code">
                    {else}
                        <div id="product_sticker_code" style="display: none;">
                    {/if}
                    <div class="form-group">
                        <label class="control-label col-lg-3">{$fieldtranslation.review_tab_name|escape:'htmlall':'UTF-8'}</label>
                        <div class="col-lg-9">
                            <input class="fixed-width-xxl help-addon" value="{$review_tab_name|escape:'htmlall':'UTF-8'}" type="text" name="review_tab_name" />
                            <div class="tooltip-ts pull-left"><button class="help">?</button><span class="tooltiptext">
                                    {l s='Please choose a name for the tab in which the Product Reviews shall be displayed.' mod='trustedshopsintegration'}
                            </span></div>
                        </div>
                    </div>
                            <div class="col-lg-3"></div>
                            <div class="col-lg-9">
                                <textarea class="form-control resizable-vertical" name="product_sticker_code" id="product_sticker_code" rows="5">{$product_sticker_code|escape:'htmlall':'UTF-8'}</textarea>
                                <p class="help-block">{$fieldtranslation.product_sticker_code|escape:'htmlall':'UTF-8'}</p>
                            </div>
                        </div>
                </div>
                {if $collect_reviews == '1'}
                    <div id="show_ratings_wrapper">
                {else}
                    <div id="show_ratings_wrapper" style="display: none">
                {/if}
                <hr class="divide" />

                        <div class="form-group">
                            <div class="control-label col-lg-3"></div>
                            <label class="control-label col-lg-3 checkbox">
                                <input id="show_rating" value="1" {if $show_rating=='1' }checked{/if} type="checkbox" name="show_rating" /> {$fieldtranslation.show_rating|escape:'htmlall':'UTF-8'}
                            </label>
                        </div>
                        {if $show_rating == 1}
                        <div id="product_widget_code" style="overflow: hidden;">
                            {else}
                            <div id="product_widget_code" style="display: none; overflow: hidden;">
                                {/if}
                                <div class="col-lg-3"></div>
                                <div class="col-lg-9">
                                    <textarea class="form-control resizable-vertical" name="product_widget_code" id="product_widget_code" rows="5">{$product_widget_code|escape:'htmlall':'UTF-8'}</textarea>
                                    <p class="help-block">{$fieldtranslation.product_widget_code|escape:'htmlall':'UTF-8'}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="col-lg-8 col-md-4">
                            <a class="help-link" href="{$help_link|escape:'htmlall':'UTF-8'}">{$fieldtranslation.need_help|escape:'htmlall':'UTF-8'}</a>
                        </div>
                        <div class="col-lg-4 col-md-8">
                            <button type="submit" name="submitTSConfig" class="btn btn-default pull-right"><i class="process-icon-save"></i> {l s='Save' mod='trustedshopsintegration'}</button>
                            <button type="submit" name="submitTSConfigAndContinue" class="btn btn-default pull-right"><i class="process-icon-save"></i> {l s='Save and continue' mod='trustedshopsintegration'}</button>
                            <a href="index.php?controller=AdminModules&amp;configure=trustedshopsintegration&amp;token={$token|escape:'htmlall':'UTF-8'}" class="btn btn-default pull-right"><i class="process-icon-cancel"></i> {l s='Cancel' mod='trustedshopsintegration'}</a>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="id_trusted_shops" value="{$id_trusted_shops|escape:'htmlall':'UTF-8'}" />
    </form>
    </div>
    <script type="text/javascript" src="../js/jquery/plugins/jquery.colorpicker.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#collect_reviews').change(function() {
                if (document.getElementById('collect_reviews').checked) {
                    $("#collect_review_settings").show();
                    $("#show_reviews_wrapper").show();
                    $("#show_ratings_wrapper").show();
                    $("#ts_info_hint").modal('show');
                } else {
                    $("#collect_review_settings").hide();
                    $("#show_reviews_wrapper").hide();
                    $("#show_ratings_wrapper").hide();
                }
            });

            $('#show_reviews').change(function() {
                if (document.getElementById('show_reviews').checked) {
                    $("#product_sticker_code").show();
                } else {
                    $("#product_sticker_code").hide();
                }
            });
            $('#show_rating').change(function() {
                if (document.getElementById('show_rating').checked) {
                    $("#product_widget_code").show();
                } else {
                    $("#product_widget_code").hide();
                }
            });
            $('#current_mode').change(function() {
                mode = $(this).val();
                if(mode == 'standard') {
                    newURL = window.location.href + '&current_mode=' + mode;
                    window.location.href = newURL;
                }
            });
        })
    </script>

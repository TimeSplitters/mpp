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
        </div>
        <div id="fieldset_1" class="panel">
            <div class="panel-heading">
                <i class="icon-tags"></i> {$fieldtranslation.info_tab_2|escape:'htmlall':'UTF-8'}
            </div>
            <div class="form-wrapper">
                <div class="form-group">
                    <label class="control-label col-lg-3">{$fieldtranslation.variant|escape:'htmlall':'UTF-8'}</label>
                    <div class="col-lg-9">
                        <select class="fixed-width-xxl" name="variant">
                            <option {if $variant == 'reviews'}selected{/if} value="reviews">{$variants.reviews|escape:'htmlall':'UTF-8'}</option>
                            <option {if $variant == 'default'}selected{/if} value="default">{$variants.default|escape:'htmlall':'UTF-8'}</option>
                            <option {if $variant == 'hide'}selected{/if} value="hide">{$variants.hide|escape:'htmlall':'UTF-8'}</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-3">{$fieldtranslation.y_offset|escape:'htmlall':'UTF-8'}</label>
                    <div class="col-lg-9">
                        <div class="input-group">
                            <span class="input-group-addon"> px</span>
                            <input class="fixed-width-xxl help-addon" type="text" value="{$y_offset|escape:'htmlall':'UTF-8'}" name="y_offset">
                            <div class="tooltip-ts pull-left"><button class="help">?</button><span class="tooltiptext">
                                    {l s='Adjust the y-axis position of your Trustbadge up to 250px vertically from the lower right corner of your shop.' mod='trustedshopsintegration'}
                            </span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="fieldset_2" class="panel">
            <div class="panel-heading">
                <i class="icon-tags"></i> {$fieldtranslation.info_tab_3|escape:'htmlall':'UTF-8'}
            </div>
            <div class="form-wrapper">
                <div class="form-group">
                    <div class="control-label col-lg-3"></div>
                    <label class="control-label col-lg-3 checkbox">
                        <input {if $collect_reviews == '1'}checked{/if} id="collect_reviews" value="1" type="checkbox" name="collect_reviews" /> {$fieldtranslation.collect_reviews|escape:'htmlall':'UTF-8'}
                    </label>
                </div>
                {* HTML/JS Content / No escaping *}
                {$ts_info_hint}
                {* HTML/JS Content / No escaping *}
                {$additional_product_attributes}
                {if $collect_reviews == '1'}
                    <div id="show_reviews_wrapper">
                {else}
                    <div id="show_reviews_wrapper" style="display: none">
                {/if}
                    <hr class="divide" />
                    <div class="form-group">
                        <div class="control-label col-lg-3"></div>
                        <label class="control-label col-lg-3 checkbox">
                            <input id="show_reviews" {if $show_reviews == '1'}checked{/if} value="1" type="checkbox" name="show_reviews" /> {$fieldtranslation.show_reviews|escape:'htmlall':'UTF-8'}
                        </label>
                    </div>
                    {if $show_reviews == '1'}
                        <div id="review_settings">
                    {else}
                        <div id="review_settings" style="display: none;">
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
                        <div class="form-group">
                            <label class="control-label col-lg-3">{$fieldtranslation.review_tab_border_color|escape:'htmlall':'UTF-8'}</label>
                            <div class="col-lg-9">
                                <div class="col-lg-2">
                                    <div class="row">
                                        <div class="input-group">
                                            <input class="mColorPicker" id="color_0" data-hex="true" type="text" value="{$review_tab_border_color|escape:'htmlall':'UTF-8'}" name="review_tab_border_color" />
                                            <span id="icp_color_0" class="mColorPickerTrigger input-group-addon" style="cursor:pointer;" data-mcolorpicker="true"><img src="../img/admin/color.png" /></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">{$fieldtranslation.review_tab_star_color|escape:'htmlall':'UTF-8'}</label>
                            <div class="col-lg-9">
                                <div class="col-lg-2">
                                    <div class="row">
                                        <div class="input-group">
                                            <input class="mColorPicker" id="color_1" data-hex="true" type="text" value="{$review_tab_star_color|escape:'htmlall':'UTF-8'}" name="review_tab_star_color" />
                                            <span id="icp_color_1" class="mColorPickerTrigger input-group-addon" style="cursor:pointer;" data-mcolorpicker="true"><img src="../img/admin/color.png" /></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">{$fieldtranslation.review_tab_background_color|escape:'htmlall':'UTF-8'}</label>
                            <div class="col-lg-9">
                                <div class="col-lg-2">
                                    <div class="row">
                                        <div class="input-group">
                                            <input class="mColorPicker" id="color_2" data-hex="true" type="text" value="{$review_tab_background_color|escape:'htmlall':'UTF-8'}" name="review_tab_background_color" />
                                            <span id="icp_color_2" class="mColorPickerTrigger input-group-addon" style="cursor:pointer;" data-mcolorpicker="true"><img src="../img/admin/color.png" /></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-3"></div>
                            <label class="control-label checkbox col-lg-9 ts-checkbox">
                                <span class="pull-left"><input {if $hide_empty_reviews == '1'}checked{/if} value="1" type="checkbox" name="hide_empty_reviews" /> {$fieldtranslation.hide_empty_reviews|escape:'htmlall':'UTF-8'}</span>
                                <div class="tooltip-ts pull-left"><button class="help">?</button><span class="tooltiptext">
                                        {l s='Hide Product Reviews until the product has received its first review; otherwise an information will be displayed' mod='trustedshopsintegration'}
                                </span></div>
                            </label>
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
                            <input id="show_rating" value="1" {if $show_rating == '1'}checked{/if} type="checkbox" name="show_rating" /> {$fieldtranslation.show_rating|escape:'htmlall':'UTF-8'}
                        </label>
                    </div>
                    {if $show_rating == '1'}
                        <div id="rating_settings">
                    {else}
                        <div id="rating_settings" style="display: none;">
                    {/if}
                        <div class="form-group">
                            <label class="control-label col-lg-3">{$fieldtranslation.rating_star_color|escape:'htmlall':'UTF-8'}</label>
                            <div class="col-lg-9">
                                <div class="col-lg-2">
                                    <div class="row">
                                        <div class="input-group">
                                            <input class="mColorPicker" value="{$rating_star_color|escape:'htmlall':'UTF-8'}" id="color_3" data-hex="true" type="text" name="rating_star_color" />
                                            <span id="icp_color_3" class="mColorPickerTrigger input-group-addon" style="cursor:pointer;" data-mcolorpicker="true"><img src="../img/admin/color.png" /></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">{$fieldtranslation.rating_star_size|escape:'htmlall':'UTF-8'}</label>
                            <div class="col-lg-9">
                                <div class="input-group">
                                    <span class="input-group-addon"> px</span>
                                    <input class="fixed-width-xxl" value="{$rating_star_size|escape:'htmlall':'UTF-8'}" name="rating_star_size" type="text" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">{$fieldtranslation.rating_font_size|escape:'htmlall':'UTF-8'}</label>
                            <div class="col-lg-9">
                                <div class="input-group">
                                    <span class="input-group-addon"> px</span>
                                    <input class="fixed-width-xxl" value="{$rating_font_size|escape:'htmlall':'UTF-8'}" name="rating_font_size" type="text" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="control-label col-lg-3"></div>
                            <label class="control-label checkbox col-lg-9 ts-checkbox">
                                <span class="pull-left"><input {if $hide_empty_ratings == '1'}checked{/if} value="1" type="checkbox" name="hide_empty_ratings" /> {$fieldtranslation.hide_empty_ratings|escape:'htmlall':'UTF-8'}</span>
                                <div class="tooltip-ts pull-left"><button class="help">?</button><span class="tooltiptext">
                                        {l s='Hide Star Ratings until the product has received its first review; otherwise a grey placeholder will be displayed' mod='trustedshopsintegration'}
                                </span></div>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <div class="col-lg-8 col-md-4">
                    <a class="help-link" target="_blank" href="{$help_link|escape:'htmlall':'UTF-8'}">{$fieldtranslation.need_help|escape:'htmlall':'UTF-8'}</a>
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
                $("#review_settings").show();
            } else {
                $("#review_settings").hide();
            }
        });
        $('#show_rating').change(function() {
            if (document.getElementById('show_rating').checked) {
                $("#rating_settings").show();
            } else {
                $("#rating_settings").hide();
            }
        });

        $('#current_mode').change(function() {
            mode = $(this).val();
            newURL = window.location.href + '&current_mode=' + mode;
            window.location.href = newURL;
        });
        $('input.mColorPicker').each(function() {
            $(this).css('background-color', $(this).val());
        });
    });
</script>

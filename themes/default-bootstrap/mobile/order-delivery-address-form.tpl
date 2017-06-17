<div>
    <h3 class="text-uppercase"><span class="icon-truck icon-l"></span> {l s='Delivery address'}</h3>
    <div>
        <div id="delivery_address_displayed" class="displayed_address{if !$logged || count($addresses) == 0} unvisible{/if}">
            {foreach from=$addresses key=k item=address}
                {if $address.id_address == $cart->id_address_delivery}
                    {assign var=theBillingAddress value=$address}
                    {if !$theBillingAddress.phone}
                        {assign var=defaultAddress value=true}
                    {/if}
                {/if}
            {/foreach}
            <button id="update_delivery_address" class="order-edit-button pull-xs-right"
                    data-address-id="{$theBillingAddress.id_address}">{l s='Edit'}</button>
            <blockquote class="user_address_blockquote" {if !$logged || count($addresses) == 0 || (count($addresses) > 0 && !$theBillingAddress.phone)}style="display: none"{/if}>
                <div>
                    <span class="displayed_address_lastname">{$theBillingAddress.lastname}</span>
                    <span class="displayed_address_firstname">{$theBillingAddress.firstname}</span>
                    <br/>
                    <span class="displayed_address_address1">{$theBillingAddress.address1}</span>
                    <span class="displayed_address_address2">{$theBillingAddress.address2}</span>
                    <br/>
                    <span class="displayed_address_postcode">{$theBillingAddress.postcode}</span>
                    <span class="displayed_address_city">{$theBillingAddress.city}</span>
                    <br/>
                    <span class="displayed_address_country">{$theBillingAddress.country}</span>
                    <br/>
                    <span class="displayed_address_phone">{$theBillingAddress.phone}</span>
                </div>
            </blockquote>

            <select name="id_address_delivery" id="id_address_delivery" class="addresses_lists">
                {foreach from=$addresses key=k item=address}
                    <option value="{$address.id_address|intval}"{if $address.id_address == $cart->id_address_delivery} selected="selected"{/if}>
                        {*$address.alias|escape:'html':'UTF-8'*}
                        {$address.lastname|escape:'html':'UTF-8'} {$address.firstname|escape:'html':'UTF-8'}
                        , {$address.address1|escape:'html':'UTF-8'} {$address.address2|escape:'html':'UTF-8'} {$address.postcode|escape:'html':'UTF-8'} {$address.city|escape:'html':'UTF-8'} {$address.phone|escape:'html':'UTF-8'}
                    </option>
                {/foreach}
            </select>
        </div>
        <form action="{$link->getPageLink('order', true)|escape:'html':'UTF-8'}"
              method="post" novalidate
              id="add_delivery_address_form" class="fieldset_form" {if !$logged || count($addresses) == 0 || !$theBillingAddress.phone}style="display: block;"{/if}>
            <div class="form_content clearfix">
                <div id="p_new_delivery_address">{l s='Fill in your delivery address'}:</div>
                <div id="p_edit_delivery_address">{l s='Edit your delivery address'}:</div>
                <div class="form-group">
                    <input type="text" class="validate form-control"
                           data-validate="isName"
                           placeholder="{l s='Last name'}"
                           name="lastname" {if isset($defaultAddress)}value="{$theBillingAddress.lastname}"{/if}/>
                    <span class="lastname_error error_message"></span>
                </div>
                <div class="form-group">
                    <input type="text" class="validate form-control"
                           data-validate="isName"
                           placeholder="{l s='First name'}"
                           name="firstname" {if isset($defaultAddress)}value="{$theBillingAddress.firstname}"{/if}/>
                    <span class="firstname_error error_message"></span>
                </div>
                <div class="form-group">
                    <input type="text" class="validate form-control autocomplete_address"
                           data-validate="isAddress" id="address1"
                           placeholder="{l s='Address'}"
                           name="address1" {if isset($defaultAddress)}value="{$theBillingAddress.address1}"{/if}/>
                    <span class="address1_error error_message"></span>
                </div>
                <div class="form-group">
                    <input type="text"
                           class="form-control"
                           placeholder="{l s='Additional address'}"
                           title="{l s='Indiquez le code de l\'immeuble, le bâtiment et l\'étage'}"
                           data-toggle="tooltip" data-placement="bottom"
                           name="address2" {if isset($defaultAddress)}value="{$theBillingAddress.address2}"{/if}/>
                    <span class="address2_error error_message"></span>
                </div>
                <div class="form-group postal_code_fieldset">
                    <input type="text" class="validate form-control"
                           data-validate="isNumber"
                           placeholder="{l s='Zip Code'}"
                           name="postal_code"
                           {if isset($defaultAddress)}value="{$theBillingAddress.postcode}"{/if}/>
                </div>
                <span class="postal_code_error error_message"></span>
                <div class="form-group country_fieldset">
                    <input type="text" class="validate form-control"
                           data-validate="isName"
                           placeholder="{l s='City'}"
                           name="locality"
                           {if isset($defaultAddress)}value="{$theBillingAddress.city}"{/if}/>
                </div>
                <span class="locality_error error_message"></span>
                <div class="form-group">
                    <input type="text" class="validate form-control"
                           data-validate="isName"
                           name="country" readonly value="France"
                           placeholder="{l s='Country'}"
                           data-toggle="tooltip" data-placement="bottom"
                           title="{l s='We deliver our products throughout France (including Corsica). For a delivery outside France, you can directly contact our customer service.'}" {if isset($defaultAddress)} value="{$theBillingAddress.country}{/if}"/>
                    <span class="country_error error_message"></span>
                </div>
                <div class="form-group phone_fieldset">
                        <input class="validate form-control"
                               data-validate="isPhoneNumber"
                               type="tel"
                               maxlength="10"
                               placeholder="{l s='Phone Number'}"
                               name="phone"
                               data-toggle="tooltip" data-placement="bottom"
                               title="{l s='Your phone number will only be used in order to manage your order.'}" id="phone" />
                    <span class="phone_error error_message"></span>
                </div>
                <input type="hidden" id="phone_required" name="phone_required" value="1" />
                <input type="hidden" name="address_alias" value="{l s='Default address'}" />
                <div>
                    {if isset($back)}<input type="hidden" class="hidden" name="back"
                                            value="{$back|escape:'html':'UTF-8'}" />{/if}

                    <input type="hidden" class="hidden" name="id_address"
                           value="{if $theBillingAddress.id_address > 0}{$theBillingAddress.id_address}{else}0{/if}"/>
                </div>
            </div>

            <div class="text-right">
                <button id="add_delivery_address_cancel"
                        class="btn btn-cancel" {if !$logged || count($addresses) == 0} style="display: none"{/if}>{l s='Cancel'}</button>
                <button id="add_delivery_address_submit" type="submit"
                        class="btn btn-default" {if !$logged || count($addresses) == 0} style="display: none"{/if}>{l s='Save'}</button>
            </div>
        </form>

        <br/>
        <div class="text-right">
            <button id="add_delivery_address" class="new-address-button"{if !$logged || count($addressesWorld) == 0 } style="display: none;"{/if}>{l s='I\'ll send it to a new address'}</button>
        </div>
    </div>
</div>
{strip}
    {addJsDef addresses=$addresses}
    {addJsDef addressesWorld=$addressesWorld}
{/strip}
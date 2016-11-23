<h3 class="text-uppercase"><span class="icon-file-text icon-l"></span> {l s='Billing address'}</h3>
<div class="fieldset_content">
    <div>{l s='Use my delivery address'}:</div>
    {foreach from=$addressesWorld key=k item=address}
        {if $address.id_address == $cart->id_address_invoice}
            {assign var=theBillingAddress value=$address}
        {/if}
    {/foreach}
    <div>
        <input type="radio" name="same" id="addressesAreEquals" value="1" {if $theBillingAddress.id_address == $cart->id_address_delivery || !$cart->id_address_delivery}checked=checked{/if} />
        <label for="addressesAreEquals"><span></span>{l s='YES'}</label>

        <input type="radio" name="same" id="addressesAreNotEquals" value="0" {if $theBillingAddress.id_address != $cart->id_address_delivery && $cart->id_address_delivery}checked=checked{/if}/>
        <label for="addressesAreNotEquals"><span></span> {l s='NO'}</label>
    </div>
    <div id="billing_address_displayed" class="displayed_address">
        <button id="update_billing_address" class="order-edit-button pull-xs-right" data-address-id="{$theBillingAddress.id_address}">{l s='Edit'}</button>
        <blockquote class="user_address_blockquote" {if !$logged || count($addressesWorld) == 0}style="display: none;"{/if}>
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
            </div>
        </blockquote>
    </div>

    {if $addressesWorld|@count > 0}
        <div id="id_address_billing_sentence">{l s='I choose another address'}:</div>
    {/if}
    <select name="id_address_billing" id="id_address_billing"
            class="margin-bottom-s addresses_lists{if !$logged || $addressesWorld|@count == 0} unvisible{/if}">
        {foreach from=$addressesWorld key=k item=address}
            <option value="{$address.id_address|intval}"{if $address.id_address == $cart->id_address_invoice} selected="selected"{/if}>
                {*$address.alias|escape:'html':'UTF-8'*}
                {$address.lastname|escape:'html':'UTF-8'} {$address.firstname|escape:'html':'UTF-8'}
                , {$address.address1|escape:'html':'UTF-8'} {$address.address2|escape:'html':'UTF-8'} {$address.postcode|escape:'html':'UTF-8'} {$address.city|escape:'html':'UTF-8'} {$address.phone|escape:'html':'UTF-8'}
            </option>
        {/foreach}
    </select>

    <form action="{$link->getPageLink('order', true)|escape:'html':'UTF-8'}"
          method="post" novalidate
          id="add_billing_address_form" class="fieldset_form">
        <div class="form_content clearfix">
            <div class="form-group">
                <input type="text" class="validate form-control"
                       data-validate="isName"
                       placeholder="{l s='Last name'}"
                       name="lastname" id="lastname" />
                <span class="lastname_error error_message"></span>
            </div>
            <div class="form-group">
                <input type="text" class="validate form-control"
                       data-validate="isName"
                       placeholder="{l s='First name'}"
                       name="firstname" id="firstname" />
                <span class="firstname_error error_message"></span>
            </div>
            <div class="form-group">
                <input type="text" class="validate form-control autocomplete_address address_world"
                       data-validate="isAddress"
                       placeholder="{l s='Address'}"
                       name="address1" id="address9" />
                <span class="address1_error error_message"></span>
            </div>
            <div class="form-group">
                    <input type="text" class="form-control"
                           placeholder="{l s='Additional address'}"
                           title="{l s='Vous pouvez nous indiquer des informations utiles pour faciliter la livraison de vos commandes (étage, code d’accès...)'}"
                           data-toggle="tooltip" data-placement="bottom"
                           name="address2" id="address2"/>
                <span class="address2_error error_message"></span>
            </div>

            <div class="form-group postal_code_fieldset">
                <input type="text" class="validate form-control"
                       data-validate="isNumber"
                       placeholder="{l s='Zip Code'}"
                       name="postal_code" id="postal_code" />
            </div>
            <span class="postal_code_error error_message"></span>
            <div class="form-group country_fieldset">
                <input type="text" class="validate form-control"
                       data-validate="isName"
                       placeholder="{l s='City'}"
                       name="locality" id="locality" />
            </div>
            <span class="locality_error error_message"></span>
            <div class="form-group">
                <input type="text" class="validate form-control"
                       data-validate="isName"
                       placeholder="{l s='Country'}"
                       name="country" id="country" />
                <span class="country_error error_message"></span>
            </div>
            <input type="hidden" class="validate form-control"
                   data-validate="isPhoneNumber"
                   name="phone" id="phone" value="0" />
            <input type="hidden" id="phone_required" name="phone_required" value="0" />

            <input type="hidden" name="address_alias" value="{l s='Default address'}" />
            <div>
                {if isset($back)}<input type="hidden" class="hidden" name="back"
                                        value="{$back|escape:'html':'UTF-8'}" />{/if}

                <input type="hidden" class="hidden"
                       value="0"/>
            </div>
        </div>
        <div class="text-right margin-bottom-s">
            <button id="add_billing_address_cancel"
                    class="order-edit-cancel btn btn-cancel"{if !$logged || count($addressesWorld) == 0} style="display: none"{/if}>{l s='Cancel'}</button>
            <button id="add_billing_address_submit" type="submit"
                    class="btn btn-default"{if !$logged || count($addressesWorld) == 0} style="display: none"{/if}>{l s='Save'}</button>
        </div>
    </form>

    <div class="text-right margin-bottom-s">
        <button id="add_billing_address"
                class="new-address-button"{if !$logged || count($addressesWorld) == 0 } style="display: none;"{/if}>{l s='I\'ll fill in another billing address'}</button>
    </div>
</div>
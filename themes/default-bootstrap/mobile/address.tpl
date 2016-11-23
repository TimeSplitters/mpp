<div class="col-xs-12 col-sm-12">
{capture name=path}{l s='Your addresses'}{/capture}
<div class="box identity-info-blocks">
	{if $smarty.get.id_address > 0}
	<h2>{l s='Modifier mon adresse: %s' sprintf=$address->alias}</h2>
	{else}
	<h2>{l s='Ajouter une adresse'}</h2>
	{/if}

	{include file="$tpl_dir./errors.tpl"}
	<form action="{$link->getPageLink('address', true)|escape:'html':'UTF-8'}{if $smarty.get.id_address > 0}?id_address={$smarty.get.id_address}&content_only=1{/if}" method="post" class="std fieldset_form" id="add_address">
		<!--h3 class="page-subheading">{if isset($id_address)}{l s='Your address'}{else}{l s='New address'}{/if}</h3-->
		{assign var="stateExist" value=false}
		{assign var="postCodeExist" value=false}
		{assign var="dniExist" value=false}
		{assign var="homePhoneExist" value=false}
		{assign var="mobilePhoneExist" value=false}
		{assign var="atLeastOneExists" value=false}
		{foreach from=$ordered_adr_fields item=field_name}
			{if $field_name eq 'company'}
				<div class="form-group hidden">
					<label for="company">{l s='Company'}{if isset($required_fields) && in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
					<input class="form-control validate" data-validate="{$address_validation.$field_name.validate}" type="text" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{else}{if isset($address->company)}{$address->company|escape:'html':'UTF-8'}{/if}{/if}" />
				</div>
			{/if}
			{*if $field_name eq 'vat_number'}
				<div id="vat_area">
					<div id="vat_number">
						<div class="form-group">
							<label for="vat-number">{l s='VAT number'}{if isset($required_fields) && in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
							<input type="text" class="form-control validate" data-validate="{$address_validation.$field_name.validate}" id="vat-number" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{else}{if isset($address->vat_number)}{$address->vat_number|escape:'html':'UTF-8'}{/if}{/if}" />
						</div>
					</div>
				</div>
			{/if*}
			{if $field_name eq 'dni'}
			{assign var="dniExist" value=true}
			<div class="required form-group dni">
				<label for="dni">{l s='Identification number'} <sup>*</sup></label>
				<input class="form-control" data-validate="{$address_validation.$field_name.validate}" type="text" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{else}{if isset($address->dni)}{$address->dni|escape:'html':'UTF-8'}{/if}{/if}" />
				<span class="form_info">{l s='DNI / NIF / NIE'}</span>
			</div>
			{/if}
			{if $field_name eq 'lastname'}
				<div class="required form-group">
					<input class="validate form-control" data-validate="isName" type="text" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{else}{if isset($address->lastname)}{$address->lastname|escape:'html':'UTF-8'}{/if}{/if}"
					placeholder="{l s='Last name'}" />
					<div id="lastname_error" class="error_message"></div>
				</div>
			{/if}
			{if $field_name eq 'firstname'}
				<div class="required form-group">
					<input class="validate form-control" data-validate="isName" type="text" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{else}{if $smarty.get.id_address > 0 && isset($address->firstname)}{$address->firstname|escape:'html':'UTF-8'}{/if}{/if}"
					placeholder="{l s='First name'}" />
					<div id="firstname_error" class="error_message"></div>
				</div>
			{/if}
			{if $field_name eq 'address1'}
				<div class="required form-group">
					<input class="validate form-control autocomplete_address" data-validate="isAddress" type="text" id="address1" name="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{else}{if isset($address->address1)}{$address->address1|escape:'html':'UTF-8'}{/if}{/if}" placeholder="{l s='Address'}" />
					<div id="address1_error" class="error_message"></div>
				</div>
			{/if}
			{if $field_name eq 'address2'}
				<div class="required form-group">
						<input class="validate form-control" data-validate="isGenericName" type="text" id="address2" name="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{else}{if isset($address->address2)}{$address->address2|escape:'html':'UTF-8'}{/if}{/if}"
							   placeholder="{l s='Additional address'}" />
					<div class="text-right">
						<em>{l s='Vous pouvez nous indiquer des informations utiles pour faciliter la livraison de vos commandes (étage, code d’accès...)'}"></em>
					</div>
					<div id="address2_error" class="error_message"></div>
				</div>
			{/if}
			{if $field_name eq 'postcode'}
				{assign var="postCodeExist" value=true}
				<div class="required postal_code_fieldset form-group">
					<input class="validate form-control" data-validate="isPostCode" type="text" id="postal_code" name="postal_code" value="{if isset($smarty.post.postal_code)}{$smarty.post.postal_code}{else}{if isset($address->postcode)}{$address->postcode|escape:'html':'UTF-8'}{/if}{/if}"
					placeholder="{l s='Post code'}" />
					<div id="postcode_error" class="error_message"></div>
				</div>
			{/if}
			{if $field_name eq 'city'}
				<div class="required form-group country_fieldset">
					<input class="validate form-control" data-validate="isCityName" type="text" id="locality" name="locality" value="{if isset($smarty.post.locality)}{$smarty.post.locality}{else}{if isset($address->city)}{$address->city|escape:'html':'UTF-8'}{/if}{/if}"
					placeholder="{l s='City'}" />
					<div id="city_error" class="error_message"></div>
				</div>
				{* if customer hasn't update his layout address, country has to be verified but it's deprecated *}
			{/if}
			{if $field_name eq 'Country:name' || $field_name eq 'country' || $field_name eq 'Country:iso_code'}
				<div class="required form-group">
					<input type="text" class="validate form-control"
						   data-validate="isName" readonly value="France"
						   name="country" id="country" title="{l s='We deliver our products throughout France (including Corsica). For a delivery outside France, you can directly contact our customer service.'}"
						   placeholder="{l s='Country'}" />
					<div id="country_error" class="error_message"></div>
				</div>
			{/if}
			{if $field_name eq 'State:name'}
				{assign var="stateExist" value=true}
				<div class="required id_state form-group">
					<label for="id_state">{l s='State'} <sup>*</sup></label>
					<select name="id_state" id="id_state" class="form-control">
						<option value="">-</option>
					</select>
				</div>
			{/if}
			{if $field_name eq 'phone'}
				{assign var="homePhoneExist" value=true}
				<div class="form-group">
					<input class="validate form-control" data-validate="isPhoneNumber" type="text" id="phone" name="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{else}{if isset($address->phone)}{$address->phone|escape:'html':'UTF-8'}{/if}{/if}" title="{l s='Your phone number will only be used in order to manage your order.'}"
					placeholder="{l s='Phone'}" />
						<input type="hidden" name="phone_required" id="phone_required" value="1" />
					<div id="phone_error" class="error_message"></div>
				</div>
				<div class="clearfix"></div>
			{/if}
			{if $field_name eq 'phone_mobile'}
				{assign var="mobilePhoneExist" value=true}
				<div class="hidden {if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
					<label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
					<input class="validate form-control" data-validate="{$address_validation.phone_mobile.validate}" type="tel" id="phone_mobile" name="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{else}{if isset($address->phone_mobile)}{$address->phone_mobile|escape:'html':'UTF-8'}{/if}{/if}" />
				</div>
			{/if}
			{if ($field_name eq 'phone_mobile') || ($field_name eq 'phone_mobile') && !isset($atLeastOneExists) && isset($one_phone_at_least) && $one_phone_at_least}
				{assign var="atLeastOneExists" value=true}
				<p class="hidden inline-infos required">** {l s='You must register at least one phone number.'}</p>
			{/if}
		{/foreach}

		<div class="required form-group" id="adress_alias">
			<input class="validate form-control" data-validate="isGenericName" type="text" id="alias" name="alias" value="{if isset($smarty.post.alias)}{$smarty.post.alias}{else}{if isset($address->alias)}{$address->alias|escape:'html':'UTF-8'}{/if}{/if}"
			placeholder="{l s='Address title'}" />
			<div id="alias_error" class="error_message"></div>
		</div>

		<div class="text-center">
			{if isset($id_address)}<input type="hidden" name="id_address" value="{$id_address|intval}" />{/if}
			{if isset($back)}<input type="hidden" name="back" value="{$back}" />{/if}
			{if isset($mod)}<input type="hidden" name="mod" value="{$mod}" />{/if}
			{if isset($select_address)}<input type="hidden" name="select_address" value="{$select_address|intval}" />{/if}
			<input type="hidden" name="token" value="{$token}" />
			<button type="submit" name="submitAddress" id="submitAddress" class="btn btn-default btn-block">
				<span>{l s='Save'}</span>
			</button>
			<br />
			<strong id="success_add" class="success_message">{l s='Your address has been created'}</strong>
			<strong id="success_update" class="success_message">{l s='Your address has been updated'}</strong>
		</div>
	</form>
</div>
</div>

{strip}
{if isset($smarty.post.id_state) && $smarty.post.id_state}
	{addJsDef idSelectedState=$smarty.post.id_state|intval}
{elseif isset($address->id_state) && $address->id_state}
	{addJsDef idSelectedState=$address->id_state|intval}
{else}
	{addJsDef idSelectedState=false}
{/if}
{if isset($smarty.post.id_country) && $smarty.post.id_country}
	{addJsDef idSelectedCountry=$smarty.post.id_country|intval}
{elseif isset($address->id_country) && $address->id_country}
	{addJsDef idSelectedCountry=$address->id_country|intval}
{else}
	{addJsDef idSelectedCountry=false}
{/if}
{if isset($countries)}
	{addJsDef countries=$countries}
{/if}
{if isset($vatnumber_ajax_call) && $vatnumber_ajax_call}
	{addJsDef vatnumber_ajax_call=$vatnumber_ajax_call}
{/if}
{/strip}

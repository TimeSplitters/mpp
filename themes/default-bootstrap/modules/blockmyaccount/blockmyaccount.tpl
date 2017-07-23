{*
* 2007-2016 PrestaShop
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<!-- Block myaccount module -->
<div class="block_my_account col-md-3 text-center">
	<div class="icon-user icon-3x"></div>
	<br />
	<span>{l s='Espace client'}</span>
	<div>
		<ul>
			<li>
				<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='My account' mod='blockmyaccount'}">
                    {l s='My account' mod='blockmyaccount'}
				</a>
			</li>
			<li>
				<a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}" title="{l s='My orders' mod='blockmyaccount'}">
					{l s='My orders' mod='blockmyaccount'}
				</a>
			</li>
			{$HOOK_BLOCK_MY_ACCOUNT}
			<li>
				<a
						href="{$link->getPageLink('index', true, NULL, "mylogout")|escape:'html':'UTF-8'}"
						title="{l s='Sign out' mod='blockmyaccount'}">
					<span>{l s='Sign out' mod='blockmyaccount'}</span>
				</a>
			</li>
		</ul>
	</div>
</div>
<!-- /Block myaccount module -->

<!DOCTYPE HTML>
<!--[if lt IE 7]>
<html class="no-js lt-ie9 lt-ie8 lt-ie7" {if isset($language_code) && $language_code}
      lang="{$language_code|escape:'html':'UTF-8'}" {/if}><![endif]-->
<!--[if IE 7]>
<html class="no-js lt-ie9 lt-ie8 ie7" {if isset($language_code) && $language_code}
      lang="{$language_code|escape:'html':'UTF-8'}" {/if}><![endif]-->
<!--[if IE 8]>
<html class="no-js lt-ie9 ie8" {if isset($language_code) && $language_code}
      lang="{$language_code|escape:'html':'UTF-8'}" {/if}><![endif]-->
<!--[if gt IE 8]>
<html class="no-js ie9" {if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"
      {/if}><![endif]-->
<html{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}>
<head>
    <meta charset="utf-8"/>
    <title>{$meta_title|escape:'html':'UTF-8'}</title>
    {if isset($meta_description) AND $meta_description}
        <meta name="description" content="{$meta_description|escape:'html':'UTF-8'}"/>
    {/if}
    {if isset($meta_keywords) AND $meta_keywords}
        <meta name="keywords" content="{$meta_keywords|escape:'html':'UTF-8'}"/>
    {/if}
    <meta name="generator" content="PrestaShop"/>
    <meta name="robots" content="{if isset($nobots)}no{/if}index,{if isset($nofollow) && $nofollow}no{/if}follow"/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, initial-scale=1.0"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png">
    <link rel="icon" type="image/png" href="/favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="/android-chrome-192x192.png" sizes="192x192">
    <link rel="icon" type="image/png" href="/favicon-96x96.png" sizes="96x96">
    <link rel="icon" type="image/png" href="/favicon-16x16.png" sizes="16x16">
    <link rel="manifest" href="/manifest.json">
    <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#ffffff">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-TileImage" content="/mstile-144x144.png">
    <meta name="theme-color" content="#000000">
    {* ON BYPASS TOUTES LES CSS DU THEME DESKTOP ET ON INJECTE PAR GULP *}
    <!-- inject:css -->
    <link rel="stylesheet" href="/themes/default-bootstrap/mobile/css/app.css?v=20161109"/>
    <!-- endinject -->

    {*<link rel="stylesheet" href="{$css_mobile_dir}/app.css" type="text/css" media="{$media|escape:'html':'UTF-8'}" />*}

    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:300,600&amp;subset=latin,latin-ext" type="text/css" media="all" />

    <script src="/themes/default-bootstrap/mobile/js/compressed.js?v=20161109"></script>
    {if $page_name == 'product'}
        {assign var=product_canonical value="?"|explode:$request}
        <link rel="canonical" href="{$product_canonical[0]}" />
        <script src="/themes/default-bootstrap/mobile/js/product.js?v=20161110"></script>
        {*<script src="/themes/default-bootstrap/js/modules/productcomments/js/productcomments.js?v=20161109"></script>*}
        {*<script src="/themes/default-bootstrap/mobile/js/ajax-cart.js"></script>*}
    {/if}
    {if $page_name == 'authentication'}
        <script src="/themes/default-bootstrap/mobile/js/authentication.js?v=20161109"></script>
    {/if}
    {if $page_name == 'password'}
        <script src="/themes/default-bootstrap/mobile/js/password.js?v=20161109"></script>
    {/if}
    {if $page_name == 'contact'}
        <script src="/themes/default-bootstrap/mobile/js/contact-form.js?v=20161109"></script>
    {/if}
    {if $page_name == 'history'}
        <script src="/themes/default-bootstrap/mobile/js/history.js?v=20161109"></script>
    {/if}
    {if $page_name == 'order-detail'}
        <script src="/themes/default-bootstrap/mobile/js/order-detail.js?v=20161109"></script>
    {/if}
    {if $page_name == 'identity'}
        <script src="/themes/default-bootstrap/mobile/js/identity.js?v=20161109"></script>
    {/if}
    {if $page_name == 'order'}
        <script src="/themes/default-bootstrap/mobile/js/cart-summary.js?v=20161109"></script>
        <script src="/themes/default-bootstrap/mobile/js/order-address.js?v=20161109"></script>
        <script src="/themes/default-bootstrap/mobile/js/authentication.js?v=20161109"></script>
        <script src="/themes/default-bootstrap/mobile/js/order.js?v=20161109"></script>
    {/if}
    {if $page_name == 'address'}
        <script src="/themes/default-bootstrap/mobile/js/address.js?v=20161109"></script>
        <script src="/themes/default-bootstrap/mobile/js/statesManagement.js?v=20161109"></script>
    {/if}
    {if $page_name == 'order-confirmation' || $page_name == 'module-paypal-submit'}
        <script src="/themes/default-bootstrap/mobile/js/order-confirmation.js?v=20161109"></script>
    {/if}

    {if isset($js_defer) && !$js_defer && isset($js_files) && isset($js_def)}
        {$js_def}
        {foreach from=$js_files item=js_uri}
            {*<script type="text/javascript" src="{$js_uri|escape:'html':'UTF-8'}"></script>*}
        {/foreach}
    {/if}

    {if Context::getContext()->shop->domain == 'www.monpotpourri.com'}
        {if Context::getContext()->shop->domain == 'www.monpotpourri.com'}
            <script>
                {literal}
                (function (i, s, o, g, r, a, m) {
                    i['GoogleAnalyticsObject'] = r;
                    i[r] = i[r] || function () {
                                (i[r].q = i[r].q || []).push(arguments)
                            }, i[r].l = 1 * new Date();
                    a = s.createElement(o),
                            m = s.getElementsByTagName(o)[0];
                    a.async = 1;
                    a.src = g;
                    m.parentNode.insertBefore(a, m)
                })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');
                {/literal}

                ga('create', 'UA-87303241-1', 'auto');
            </script>
        {/if}
    {/if}
    {$HOOK_MOBILE_HEADER}
</head>
<body{if isset($page_name)} id="{$page_name|escape:'html':'UTF-8'}"{/if}
        class="{if isset($page_name)}{$page_name|escape:'html':'UTF-8'}{/if}{if isset($body_classes) && $body_classes|@count} {implode value=$body_classes separator=' '}{/if}{if $hide_left_column} hide-left-column{else} show-left-column{/if}{if $hide_right_column} hide-right-column{else} show-right-column{/if}{if isset($content_only) && $content_only} content_only{/if} lang_{$lang_iso} body-offcanvas">
{if !isset($content_only) || !$content_only}
<!-- MAIN container -->
<div id="offcanvas-overlay"></div>
<div id="cookieLaw">
    {l s='Nous utilisons des cookies pour améliorer votre expérience sur monpotpourri.'}&nbsp;
    <button class="btn btn-xs btn-primary">{l s='J\'ai compris'}</button>
</div>
{if isset($restricted_country_mode) && $restricted_country_mode}

{/if}
{if isset($countryObj) && $countryObj->country_code != 'FR'}
    <div id="restricted-country">
        <div class="container text-center">
            <button id="restricted-country-close" class="pull-xs-right">
                <span class="icon-times"></span>
            </button>
            We <span class="icon-heart"></span> <span class="bold">{$countryObj->country_name|escape:'html':'UTF-8'}</span>. We are shipping worldwide! Contact us per mail with the products you want to order and we provide you with shipping rates: <a href="mailto:hello@monpotpourri.com">hello@monpotpourri.com</a>
        </div>
    </div>
{/if}
<div class="container-fluid">
    <header class="clearfix">
        <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle offcanvas-toggle pull-xs-left" data-toggle="offcanvas"
                            data-target="#js-bootstrap-offcanvas">
                    <span>
                        <span class="sr-only">Toggle navigation</span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                     </span>
                    </button>
                    <span id="header_shortlinks">
                        <a href="{$link->getPageLink('order')}" class="valign-middle">
                            <span class="icon-shopping-basket"></span> <strong>{$cart_qties}</strong>
                        </a>
                    </span>
                    {hook h='displayMobileTopSiteMap'}
                    <div class="navbar-brand">
                        <a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}">
                            {*<img src="{$logo_url}" alt="{$shop_name|escape:'html':'UTF-8'}"/>*}
                            Mon Pot Pourri
                        </a>
                    </div>
                </div>
                <div class="navbar-offcanvas navbar-offcanvas-touch" id="js-bootstrap-offcanvas">
                    <div id="navbar_box_decouverte">
                        <img src="/themes/default-bootstrap/img/box-culturelle-02.jpg" class="img-fluid">
                        <small>{l s='Le Pot Pourri "Découverte" du mois est arrivé !'}</small>
                    </div>

                    <ul class="nav navbar-nav text-uppercase" role="menu">
                        {hook h='displayNav'}
                        <li>
                            {if $is_logged}
                                <a href="{$link->getPageLink('my-account')|escape:'html':'UTF-8'}">
                                    <span class="icon-user"></span>
                                    {if $cookie->customer_firstname != ''}
                                        {l s='Hello, %s !' sprintf=$cookie->customer_firstname}
                                    {else}
                                        {l s='Hello!' sprintf=$cookie->customer_firstname}
                                    {/if}
                                </a>
                            {else}
                                <a href="{$link->getPageLink('authentication')|escape:'html':'UTF-8'}"><span class="icon-user"></span> {l s='Se connecter'}</a>
                            {/if}
                        </li>
                    </ul>
                    {if $is_logged}
                        <ul class="nav navbar-nav text-uppercase">
                            <li><a href="{$link->getPageLink('my-account')}">{l s='Mon compte'}</a></li>
                            <li>
                                <a href="{$link->getModuleLink('blockwishlist', 'mywishlist', array(), true)|escape:'html':'UTF-8'}">{l s='Ma wishlist'}</a>
                            </li>
                            <li>
                                <a href="?mylogout">{l s='Fermer ma session'}</a>
                            </li>
                        </ul>
                    {/if}
                </div>
            </div>
        </nav>
    </header>
    {*if $page_name !='index' && $page_name !='pagenotfound'}
                            {if !($page_name =='order' && $smarty.get.step == '1')}
                                <div class="row">
                                    <div class="col-md-12">{include file="$tpl_dir./breadcrumb.tpl"}</div>
                                </div>
                            {/if}
    {/if*}
{else}
    <div class="container-fluid">
        <header class="clearfix">
            <nav class="navbar navbar-default" role="navigation">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <div class="navbar-brand">
                            <a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}">
                                <img src="{$logo_url}" alt="{$shop_name|escape:'html':'UTF-8'}"/>
                            </a>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
    </div>
{/if}
<div class="row gutter-10">
    <div class="product_choice col-xs-12">
        <h4>
            <a href="#product_choice_choisir_livre">
                <span class="icon-caret-down pull-xs-right"></span> <span
                        class="icon-hand"></span> <input type="radio" class="hidden" name="product_choice" value="livre"
                                                         id="product_choice_livre"> <label
                        for="product_choice_livre">{l s='Je choisis mon livre'}</label>
            </a>
        </h4>
        <div id="product_choice_choisir_livre" class="row">
            <div class="form-group col-xs-12">
                <label for="book_name">{l s='Titre du livre souhaité'}: </label>
                <input type="text" name="book_name" id="book_name" class="form-control"/>
                {*<button name="book_name_search" class="col-xs-2 btn btn-default">
                    <span class="icon-search"></span>
                </button>
            <div id="search_book"></div>*}
            </div>
        </div>
    </div>
    <div class="product_choice col-xs-12">
        <h4>
            <a href="#product_choice_surprise">
                <span class="icon-caret-down pull-xs-right"></span> <span
                        class="icon-gift"></span> <input type="radio" class="hidden" name="product_choice" value="surprise"
                                                         id="product_choice_questionnaire"> <label
                        for="product_choice_questionnaire">{l s='Je vous laisse choisir'}</label>
            </a>
        </h4>
        <div id="product_choice_surprise" class="row">
            <div class="col-xs-12">
                <div>{l s='Nous choisissons pour vous le meilleur livre selon les critères suivants :'} </div>
                <h5>{l s='Vous êtes :'}</h5>
                <input type="radio" name="gender" value="Un homme" id="gender_homme"/> <label
                        for="gender_homme">{l s='Un homme'}</label>
                <br/>
                <input type="radio" name="gender" value="Une femme" id="gender_femme"/> <label
                        for="gender_femme">{l s='Une femme'}</label>

                <h5>{l s='Vous avez entre :'}</h5>
                <div class="row gutter-10">
                    <div class="col-xs-6">
                        <input type="radio" name="age_range" value="13-17 ans" id="age_13-17"/>
                        <label
                                for="age_13-17">{l s='13-17 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="18-24 ans" id="age_18-24"/>
                        <label
                                for="age_18-24">{l s='18-24 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="25-34 ans" id="age_25-34"/>
                        <label
                                for="age_25-34">{l s='25-34 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="35-44 ans" id="age_35-44"/>
                        <label
                                for="age_35-44">{l s='35-44 ans'}</label>
                    </div>
                    <div class="col-xs-6">
                        <input type="radio" name="age_range" value="45-54 ans" id="age_45-54"/>
                        <label
                                for="age_45-54">{l s='45-54 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="55-64 ans" id="age_55-64"/>
                        <label
                                for="age_55-64">{l s='55-64 ans'}</label>
                        <br/>
                        <input type="radio" name="age_range" value="65+" id="age_65"/> <label
                                for="age_65">{l s='65+'}</label>
                    </div>
                </div>
                <h5>{l s='Quel genre souhaitez-vous ?'}</h5>
                <input type="radio" name="genre" value="Littérature française"
                       id="litterature_française"/> <label
                        for="litterature_française">{l s='Littérature française'}</label>
                <br/>
                <input type="radio" name="genre" value="Policier / Suspense / Thriller / Polar"
                       id="policier_suspense"/> <label
                        for="policier_suspense">{l s='Policier / Suspense / Thriller / Polar'}</label>
                <br/>
                <input type="radio" name="genre" value="Sentimental" id="sentimental"/> <label
                        for="sentimental">{l s='Sentimental'}</label>
                <br/>
                <input type="radio" name="genre" value="Fantasy / Science-Fiction"
                       id="fantasy_sf"/> <label
                        for="fantasy_sf">{l s='Fantasy / Science-Fiction'}</label>
                <br/>
                <input type="radio" name="genre" value="Biographie / Témoignage" id="bio_temo"/>
                <label for="bio_temo">{l s='Biographie / Témoignage'}</label>
                <br/>
                <input type="radio" name="genre"
                       value="Littérature étrangère (VO ou VF à préciser)"
                       id="litterature_etrangere"/> <label
                        for="litterature_etrangere">{l s='Littérature étrangère (VO ou VF à préciser)'}</label>
                <br/>
                <input type="radio" name="genre" value="BD / Manga" id="bd_manga"/> <label
                        for="bd_manga">{l s='BD / Manga'}</label>
                <br/>
                <input type="radio" name="genre" value="Poésie / Théâtre" id="poesie_theatre"/>
                <label for="poesie_theatre">{l s='Poésie / Théâtre'}</label>


                <h5>{l s='Précisez-nous ce que vous attendez de lire'}</h5>
                <small>{l s='Précision du genre, VO ou VF, thème du livre... (30 caractères min.)'}</small>
                <textarea name="description_attentes"></textarea>

                <br/>
                <h5>{l s='Avez-vous déjà lu des livres dans ce genre-là ?'}</h5>
                <small>{l s='Si oui, le(s)quel(s) et qu\'en avez-vous pensé ? (30 caractères min.)'}</small>
                <textarea name="description_genre"></textarea>

                <br/>
                <h5>{l s='Voulez-vous que l\'on vous soumette notre choix ?'}</h5>
                <input type="radio" name="soumission_choix"
                       value="Oui, je souhaite valider le choix" id="soumission_oui"/>
                <label for="soumission_oui">{l s='Oui, je souhaite valider le choix'}</label>

                <br/>
                <input type="radio" name="soumission_choix" value="Non, surprenez-moi !"
                       id="soumission_non"/>
                <label for="soumission_non">{l s='Non, surprenez-moi !'}</label>

                {*<br/>
                <h5>{l s='Allez-vous offrir ce Pot Pourri à quelqu\'un ?'}</h5>
                <input type="radio" name="cadeau" value="Oui, je souhaite valider le choix"
                       id="cadeau_oui"/>
                <label for="cadeau_oui">{l s='Oui'}</label>

                <br/>
                <input type="radio" name="cadeau" value="Non, surprenez-moi !" id="cadeau_non"/>
                <label for="cadeau_non">{l s='Non'}</label>*}
                <hr/>
            </div>
        </div>
    </div>
</div>
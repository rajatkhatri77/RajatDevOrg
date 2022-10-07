import { LightningElement } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import owlCarousel from '@salesforce/resourceUrl/owlCarousel';
import trailheadLogo from '@salesforce/resourceUrl/trailhead_logo';
import trailheadCharacters from '@salesforce/resourceUrl/trailhead_characters';
import fullimage from '@salesforce/resourceUrl/fullimage';

export default class OwlCarousel extends LightningElement {

    trailheadLogoUrl = trailheadLogo;
    einsteinUrl = trailheadCharacters;
    justTest=fullimage;
    
    // $('.owlCarousel').owlCarousel({
    //     loop:true,
    //     margin:10,
    //     nav:true,
    //     responsive:{
    //         0:{
    //             items:1
    //         },
    //         600:{
    //             items:3
    //         },
    //         1000:{
    //             items:5
    //         }
    //     }
    // })

    renderedCallback() {
        console.log(this.justTest);
        console.log(trailheadLogo);
        if(this.initialRender){return;}
        this.initialRender = true;
        loadScript(this, owlCarousel + '/jquery-3.6.0.min.js') 
            .then(e => {
                loadStyle(this, owlCarousel + '/owl.theme.default.min.css'),
                loadStyle(this, owlCarousel +'/owl.carousel.min.css'),
                loadScript(this, owlCarousel + '/owl.carousel.min.js')
                .then(() => {
                    const carousel = this.template.querySelector('div[class="owl-carousel owl-theme"]');
                    window.$(carousel).owlCarousel({
                        loop:true,
                        nav:true,
                        responsive:{
                            0:{
                                items:1
                            },
                            600:{
                                items:3
                            },
                            1000:{
                                items:5
                            }
                        }
                    })
                })
          })
    }
}
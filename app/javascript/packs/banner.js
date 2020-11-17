import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Accéder aux meilleurs freelances n'a jamais été aussi facile.", "Trouvez votre expert parmi les centaines de freelances"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };

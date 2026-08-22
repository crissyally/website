/* Flourish Counseling — shared site behavior (lightweight; Squarespace provides equivalents natively) */
(function(){
  var hdr=document.getElementById('hdr');
  if(hdr){addEventListener('scroll',function(){hdr.classList.toggle('scrolled',scrollY>30);},{passive:true});}

  /* mobile drawer */
  var openBtn=document.querySelector('.menu-btn'),drawer=document.getElementById('drawer'),
      closeBtn=document.querySelector('.drawer .close');
  if(openBtn&&drawer){openBtn.addEventListener('click',function(){drawer.classList.add('open');});}
  if(closeBtn&&drawer){closeBtn.addEventListener('click',function(){drawer.classList.remove('open');});}
  if(drawer){drawer.querySelectorAll('a').forEach(function(a){a.addEventListener('click',function(){drawer.classList.remove('open');});});}

  /* fade-in on scroll */
  var els=document.querySelectorAll('.reveal');
  if('IntersectionObserver' in window){
    var io=new IntersectionObserver(function(entries){
      entries.forEach(function(e){if(e.isIntersecting){e.target.classList.add('in');io.unobserve(e.target);}});
    },{threshold:.12,rootMargin:'0px 0px -8% 0px'});
    els.forEach(function(el,i){el.style.transitionDelay=(Math.min(i%3,2)*0.08)+'s';io.observe(el);});
  } else { els.forEach(function(el){el.classList.add('in');}); }
})();

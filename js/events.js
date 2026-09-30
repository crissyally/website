(function(){
  var list=document.getElementById('events-list');
  var status=document.getElementById('events-status');
  var profileUrl='https://www.eventbrite.com/o/flourish-counseling-co-27704105675';
  if(!list)return;

  function escapeHtml(value){
    return String(value==null?'':value).replace(/[&<>"']/g,function(char){
      return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[char];
    });
  }

  function safeUrl(value){
    try{
      var parsed=new URL(value);
      return parsed.protocol==='https:'?parsed.href:'#';
    }catch(_){return '#';}
  }

  function formatDate(event){
    var start=new Date(event.start.utc),end=new Date(event.end.utc);
    var date=new Intl.DateTimeFormat('en-US',{weekday:'long',month:'long',day:'numeric',year:'numeric',timeZone:event.timezone}).format(start);
    var startTime=new Intl.DateTimeFormat('en-US',{hour:'numeric',minute:'2-digit',timeZone:event.timezone}).format(start);
    var endTime=new Intl.DateTimeFormat('en-US',{hour:'numeric',minute:'2-digit',timeZoneName:'short',timeZone:event.timezone}).format(end);
    return {date:date,time:startTime+'&ndash;'+endTime};
  }

  function eventMarkup(event){
    var timing=formatDate(event);
    var location=event.online?'Online event':((event.venue&&event.venue.name)||'Event location');
    var locationDetail=event.online?'Joining details provided after registration':((event.venue&&event.venue.address)||'See Eventbrite for details');
    var description=event.summary||event.description||'View the full event details and reserve your spot through Eventbrite.';
    var availability=event.soldOut?'Sold Out':(event.free?'Free':(event.price||'Registration Open'));
    var image=event.image?safeUrl(event.image):'assets/photos/women-group.jpg';
    var url=safeUrl(event.url);
    return '<article class="event-card reveal in">'+
      '<div class="event-art"><img src="'+escapeHtml(image)+'" alt="'+escapeHtml(event.name)+'" loading="lazy" decoding="async"></div>'+
      '<div class="event-body">'+
        '<div class="event-labels"><span class="event-label">'+escapeHtml(availability)+'</span><span class="event-label">'+escapeHtml(event.online?'Online Workshop':'Event')+'</span></div>'+
        '<h2 class="t-title">'+escapeHtml(event.name)+'</h2>'+
        '<p class="event-summary">'+escapeHtml(description)+'</p>'+
        '<div class="event-meta">'+
          '<div class="event-meta-item"><svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="5" width="18" height="16" rx="2"></rect><path d="M8 3v4M16 3v4M3 10h18"></path></svg><div><strong>'+escapeHtml(timing.date)+'</strong>'+timing.time+'</div></div>'+
          '<div class="event-meta-item"><svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="9"></circle><path d="M3 12h18M12 3c2.3 2.5 3.5 5.5 3.5 9S14.3 18.5 12 21M12 3C9.7 5.5 8.5 8.5 8.5 12S9.7 18.5 12 21"></path></svg><div><strong>'+escapeHtml(location)+'</strong>'+escapeHtml(locationDetail)+'</div></div>'+
        '</div>'+
        '<div class="event-actions">'+
          '<button class="btn btn-solid eventbrite-trigger" id="eventbrite-widget-modal-trigger-'+escapeHtml(event.id)+'" type="button" data-event-id="'+escapeHtml(event.id)+'" data-event-url="'+escapeHtml(url)+'"'+(event.soldOut?' disabled':'')+'>'+(event.soldOut?'Sold Out':'Reserve Your Spot')+'</button>'+
          '<a class="event-details" href="'+escapeHtml(url)+'" target="_blank" rel="noopener">View full details on Eventbrite &rarr;</a>'+
        '</div>'+
      '</div></article>';
  }

  function directLinks(events){
    events.forEach(function(event){
      var trigger=document.getElementById('eventbrite-widget-modal-trigger-'+event.id);
      if(trigger&&!trigger.disabled){trigger.addEventListener('click',function(){window.open(event.url,'_blank','noopener');});}
    });
  }

  function connectCheckout(events){
    if(location.protocol!=='https:'){directLinks(events);return;}
    var script=document.createElement('script');
    script.src='https://www.eventbrite.com/static/widgets/eb_widgets.js';
    script.onload=function(){
      if(!window.EBWidgets){directLinks(events);return;}
      events.forEach(function(event){
        if(event.soldOut)return;
        window.EBWidgets.createWidget({
          widgetType:'checkout',eventId:event.id,modal:true,
          modalTriggerElementId:'eventbrite-widget-modal-trigger-'+event.id,
          onOrderComplete:function(){},
          themeSettings:{brandColor:'#413e39',fontColor:'#413e39',background:'#f8f8ec'}
        });
      });
    };
    script.onerror=function(){directLinks(events);};
    document.head.appendChild(script);
  }

  function showEmpty(){
    list.innerHTML='<div class="events-empty reveal in"><span class="eyebrow">Check Back Soon</span><h2 class="t-title mt-s">No upcoming events are scheduled.</h2><p>Follow Flourish Counseling Co. on Eventbrite to hear when registration opens for something new.</p><a class="btn btn-solid" href="'+profileUrl+'" target="_blank" rel="noopener">Follow on Eventbrite</a></div>';
  }

  if(location.protocol!=='http:'&&location.protocol!=='https:'){
    directLinks([{id:'2002459943596',url:'https://www.eventbrite.com/e/understanding-anxiety-tickets-2002459943596?aff=oddtdtcreator'}]);
    return;
  }

  fetch('/.netlify/functions/eventbrite-events',{headers:{Accept:'application/json'}})
    .then(function(result){if(!result.ok)throw new Error('Event feed unavailable');return result.json();})
    .then(function(data){
      var events=Array.isArray(data.events)?data.events:[];
      if(!events.length){showEmpty();}
      else{list.innerHTML=events.map(eventMarkup).join('');connectCheckout(events);}
      if(status){status.innerHTML='Event details are synced with <a href="'+profileUrl+'" target="_blank" rel="noopener">Eventbrite</a> and refresh automatically.';}
    })
    .catch(function(){
      directLinks([{id:'2002459943596',url:'https://www.eventbrite.com/e/understanding-anxiety-tickets-2002459943596?aff=oddtdtcreator'}]);
      if(status){status.innerHTML='Live updates are temporarily unavailable. You can still register through <a href="'+profileUrl+'" target="_blank" rel="noopener">Eventbrite</a>.';}
    });
})();

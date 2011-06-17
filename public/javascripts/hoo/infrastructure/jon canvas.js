
    var HTML5Handler = {
        createPlayer: function(){
          this.audio = new AudioPlayer();
          var self=this;
          this.audio.timeupdate(function(){
            self.buffering = !this.currentTime();
            var newProgress = this.currentTime() / this.duration();
            var time = (new Date()).getTime();
            if (!self.lastUpdate || self.lastUpdate<time-1000 || newProgress<self.playbackProgress) {
              // ignore discontinuous updates
              self.playbackVelocity=0;
            } else {
              self.playbackVelocity = (newProgress-self.playbackProgress)/(time-self.lastUpdate);
            }
            self.lastUpdate = time;
            self.playbackProgress = newProgress;
          });
          this.audio.play(function(){
            clearInterval(self.timer);
            self.timer = setInterval(function(){self.draw();}, 33);
          });
          this.audio.pause(function(){
            self.draw();
            self.lastUpdate=0;
            clearInterval(self.timer);
          });
          this.audio.ended(function(){
            self.playbackProgress = 1;
            self.playbackVelocity = 0;
            self.draw();
            clearInterval(self.timer);
          });
        },
        draw : function() {
          var canvas = this.canvas&&this.canvas[0];
          if (!canvas || !canvas.parentNode)
            return;
          var currentTime = (new Date()).getTime();
          var ctx = canvas.getContext('2d'),
              width=canvas.width,
              height=canvas.height,
              circleRadius=width*0.45;

          var baseColor = $(canvas).attr('data-baseColor') || '#000';
          ctx.clearRect(0,0,width,height);

          ctx.fillStyle = baseColor;
          ctx.beginPath();
          ctx.arc(width/2, height/2, circleRadius, 0, Math.PI*2, false);
          ctx.fill();
          ctx.closePath();

          if (this.buffering) {
            // display a rotatey thing to indicate buffering
            // ctx.arc doesn't like having huge numbers for its parameters, so subtract the start time from the current time to give more sensible numbers
            if (!this.startTime) this.startTime = (new Date()).getTime();
            var t= (currentTime - this.startTime)/500.0,
                t2 = t+1.5,
                innerRadius = circleRadius*Math.cos(1.5);  //we want a gradient tangential to the circle at the front-edge of the buffering spinner
            var bufferingGradient = ctx.createLinearGradient(width/2 + circleRadius*Math.cos(t), height/2 + circleRadius*Math.sin(t),
                                                             width/2 + innerRadius*Math.cos(t2), height/2 + innerRadius*Math.sin(t2));
            bufferingGradient.addColorStop(0, baseColor);
            bufferingGradient.addColorStop(0.9, '#888');
            bufferingGradient.addColorStop(1, baseColor);
            ctx.fillStyle = bufferingGradient;
            ctx.beginPath();
            ctx.moveTo(width/2,height/2);
            ctx.arc(width/2, height/2, circleRadius, t,t2, false);
            ctx.fill();
            ctx.closePath();
          } else {
            // interpolate the current progress forwards, to give a smoother animation:
            var interpolatedProgress = this.playbackProgress;
            if (this.lastUpdate) interpolatedProgress += this.playbackVelocity*(currentTime - this.lastUpdate);

            ctx.fillStyle = "#FABE20";
            ctx.beginPath();
            ctx.moveTo(width/2,height/2);
            ctx.arc(width/2, height/2, circleRadius, -Math.PI/2, -Math.PI/2+2*Math.PI*interpolatedProgress, false);
            ctx.fill();
            ctx.closePath();
          }
        },

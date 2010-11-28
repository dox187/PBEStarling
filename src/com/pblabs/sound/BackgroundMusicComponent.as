/*******************************************************************************
 * PushButton Engine
 * Copyright (C) 2009 PushButton Labs, LLC
 * For more information see http://www.pushbuttonengine.com
 *
 * This file is licensed under the terms of the MIT license, which is included
 * in the License.html file at the root directory of this SDK.
 ******************************************************************************/
package com.pblabs.sound
{

    import com.pblabs.engine.resource.SoundResource;
    import com.pblabs.engine.time.TickedComponent;
    
    /**
     * Simple component to manage background music.
     */
    public class BackgroundMusicComponent extends TickedComponent
    {
		[Inject]
		public var soundManager:SoundManager;
		
        protected var handle:SoundHandle;
        
        public var music:SoundResource;
        public var musicUrl:String;
        public var autoStart:Boolean = true;
        
        private var _playing:Boolean = false;
        
        public function get playing():Boolean { return _playing; }
        
        public function start():void
        {
            _playing = true;
            
            if (!handle && (!music || !music.isLoaded) && !musicUrl)
                return;
            
            if(!handle)
            {
                if (music)
                    handle = soundManager.play(music, SoundManager.MUSIC_MIXER_CATEGORY, 0, int.MAX_VALUE);
                else if (musicUrl)
                    handle = soundManager.stream(musicUrl, SoundManager.MUSIC_MIXER_CATEGORY, 0, int.MAX_VALUE);
            }
            else if(!handle.isPlaying)
            {
                handle.resume();
            }
        }
        
        public function stop():void
        {
            _playing = false;
            if (handle)
            {
                handle.stop();
                handle = null;
            }
        }
        
        override protected function onAdd() : void
        {
            super.onAdd();
            
            if(autoStart)
                start();
        }
        
        override protected function onRemove() : void
        {
            super.onRemove();
            
            stop();
        }
        
        override public function onTick(tickRate:Number) : void
        {
            // Not playing? Nothing to do.
            if (!_playing)
                return;
            
            // We're already playing and have a handle. don't do anything.
            if (_playing && handle)
                return;
            
            // Playing and no handle yet. Wait for our resource.
            if (!music || !music.isLoaded)
                return;
            
            // Resource is loaded. Finally we can play.
            start();
        }
    }
}
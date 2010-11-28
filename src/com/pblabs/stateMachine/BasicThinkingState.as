/*******************************************************************************
 * PushButton Engine
 * Copyright (C) 2009 PushButton Labs, LLC
 * For more information see http://www.pushbuttonengine.com
 *
 * This file is licensed under the terms of the MIT license, which is included
 * in the License.html file at the root directory of this SDK.
 ******************************************************************************/
package com.pblabs.stateMachine
{

    import com.pblabs.engine.core.PropertyReference;

    public class BasicThinkingState extends BasicState implements IThinkingState
    {
        public var durationProperty:PropertyReference;
        protected var _duration:int = 0;

        public function set duration(value:int):void
        {
            _duration = value;
        }
        
        public function getDuration(fsm:IMachine):int
        {
            if(durationProperty)
               return fsm.propertyBag.getProperty(durationProperty);             
            return _duration;
        }
        
        public function getTimeForNextTick(fsm:IMachine):int
        {
			throw new Error("The method 'getTimeForNextTick' on BasicThinkingState is currently not implemented.");
			
            //return context.processManager.virtualTime + getDuration(fsm);
			return -1;
        }
    }
}
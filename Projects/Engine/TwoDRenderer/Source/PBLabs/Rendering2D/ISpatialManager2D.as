package PBLabs.Rendering2D
{
   import PBLabs.Engine.Core.ObjectType;
   import flash.geom.*;
   
   /**
    * Basic interface for 2D spatial database.
    * 
    * This provides enough capabilities to do visibility culling, limited picking,
    * and ray casts.
    * 
    * Most implementations (like ones using a physics library) will expose a
    * lot more functionality, but this is enough to do rendering and UI tasks.
    */ 
   public interface ISpatialManager2D
   {
      /**
       * Add a generic spatial object to this manager. A manager with advanced
       * functionality will support both general ISpatialObject2D implementations
       * as well as enabling special functionality for its peered classes.
       */ 
      function AddSpatialObject(object:ISpatialObject2D):void;

      /**
       * Remove a previously registered object from this manager.
       * 
       * @see AddSpatialObject
       */ 
      function RemoveSpatialObject(object:ISpatialObject2D):void;
      
      /**
       * Return all the spatial objects that overlap with the specified box and match
       * one or more of the types in the mask.
       * 
       * @return True if one or more objects were found and push()'ed to results.
       */ 
      function QueryRectangle(box:Rectangle, mask:ObjectType, results:Array):Boolean;
      
      /**
       * Return all the spatial objects that overlap the specified circle.
       * 
       * @see QueryRectangle
       */ 
      function QueryCircle(center:Point, radius:Number, mask:ObjectType, results:Array):Boolean;
      
      /**
       * Cast a ray and (optionally) return information about what it hits in result.
       */
       function CastRay(start:Point, end:Point, mask:ObjectType, result:RayHitInfo):Boolean;      
   }
}
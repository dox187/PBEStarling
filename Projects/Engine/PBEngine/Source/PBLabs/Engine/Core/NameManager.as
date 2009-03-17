package PBLabs.Engine.Core
{
   import PBLabs.Engine.Entity.IEntity;
   import PBLabs.Engine.Entity.IEntityComponent;
   import PBLabs.Engine.Debug.Logger;
   
   import flash.utils.Dictionary;
   
   /**
    * The name manager stores references to entites that have been given
    * names. These entities can then be looked up by that name.
    * 
    * @see ../../../../../Reference/NameManager.html The Name Manager
    */
   public class NameManager
   {
      /**
       * The singleton NameManager instance.
       */
      static public function get Instance():NameManager
      {
         if (_instance == null)
            _instance = new NameManager();
         
         return _instance;
      }
      
      static private var _instance:NameManager = null;
      
      /**
       * The list of registered entities.
       */
      public function get EntityList():Dictionary
      {
         return _entities;
      }
      
      /**
       * Registers an entity under a specific name. If the name is in use, lookups will
       * return the last entity added under the name.
       * 
       * @param entity The entity to add.
       * @param name The name to register the entity under.
       */
      public function AddEntity(entity:IEntity, name:String):void
      {
         if (_entities[name] != null)
            Logger.PrintWarning(this, "AddEntity", "An entity with the name " + name + " already exists. Future lookups by this name will return this new entity. Did you mean to make this entity a template?");
         
         _entities[name] = entity;
      }
      
      /**
       * Removes an entity from the manager.
       * 
       * @param entity The entity to remove.
       */
      public function RemoveEntity(entity:IEntity):void
      {
         _entities[entity.Name] = null;
         delete _entities[entity.Name];
      }
      
      /**
       * Looks up an entity with the specified name.
       * 
       * @param name The name of the entity to lookup.
       * 
       * @return The entity with the specified name, or null if it wasn't found.
       */
      public function Lookup(name:String):IEntity
      {
         return _entities[name];
      }
      
      /**
       * Turns a potentially used name and returns a related unused name. The
       * given name will have a number appended, with the number continually
       * incremented until an unused name is found.
       * 
       * @param name The name to validate.
       * 
       * @return The validated name. This is guaranteed to not be in use.
       */
      public function ValidateName(name:String):String
      {
         if (_entities[name] == null)
            return name;
         
         var index:int = 1;
         var testName:String = name + index;
         while (_entities[testName] != null)
            testName = name + index++;
         
         return testName;
      }
      
      /**
       * Looks up a component on an entity that has been registered. The same
       * conditions apply as with the LookupComponentByType method on IEntity.
       * 
       * @param The name of the entity on which the component exists.
       * @param componentType The type of the component to lookup.
       * 
       * @see PBLabs.Engine.Entity.IEntity#LookupComponentByType()
       */
      public function LookupComponentByType(name:String, componentType:Class):IEntityComponent
      {
         var entity:IEntity = Lookup(name);
         if (entity == null)
            return null;
         
         return entity.LookupComponentByType(componentType);
      }
      
      /**
       * Looks up a component on an entity that has been registered. The same
       * conditions apply as with the LookupComponentByName method on IEntity.
       * 
       * @param The name of the entity on which the component exists.
       * @param componentName The name of the component to lookup.
       * 
       * @see PBLabs.Engine.Entity.IEntity#LookupComponentByName()
       */
      public function LookupComponentByName(name:String, componentName:String):IEntityComponent
      {
         var entity:IEntity = Lookup(name);
         if (entity == null)
            return null;
         
         return entity.LookupComponentByName(componentName);
      }
      
      private var _entities:Dictionary = new Dictionary();
   }
}
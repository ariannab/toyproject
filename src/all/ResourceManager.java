package all;

public class ResourceManager {

    /** The resource managed. */
    private Resource resource;

    /**
     * Initialize the manager and the managed resource
     */
    public ResourceManager() {
        this.resource = new Resource(true);
    }

    /**
     * Tells if it is possible to use the resource.
     *
     * @return true if the resource is not locked, false otherwise
     */
    public boolean canUseResource(){
        // bug! Should be: !resource.isLocked();
        return resource.isLocked();
    }

    /**
     * Getter for field resource.
     *
     * @return the resource managed
     */
    public Resource getResource() {
        return resource;
    }


    /**
     *
     * @param integer an int, must be positive
     */
    public void canUseParameter(int integer) throws IllegalArgumentException{
        if(integer<=0)
            throw new IllegalArgumentException();

    }

}

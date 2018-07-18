package all;

public class Resource {

    /** Tells whether the resource is locked. */
    private boolean locked;

    /**
     * Initialize this resource
     *
     * @param locked true if the resource is locked, false otherwise
     */
    public Resource(boolean locked) {
        this.locked = locked;
    }

    /**
     * Getter for field {@code locked}.
     *
     * @return true if this resource is locked, false otherwise
     */
    public boolean isLocked() {
        return locked;
    }

}

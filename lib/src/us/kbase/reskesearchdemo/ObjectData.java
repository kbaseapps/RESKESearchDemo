
package us.kbase.reskesearchdemo;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import us.kbase.common.service.UObject;


/**
 * <p>Original spec-file type: ObjectData</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "guid",
    "parent_guid",
    "object_name",
    "timestamp",
    "parent_data",
    "data",
    "key_props"
})
public class ObjectData {

    @JsonProperty("guid")
    private java.lang.String guid;
    @JsonProperty("parent_guid")
    private java.lang.String parentGuid;
    @JsonProperty("object_name")
    private java.lang.String objectName;
    @JsonProperty("timestamp")
    private Long timestamp;
    @JsonProperty("parent_data")
    private UObject parentData;
    @JsonProperty("data")
    private UObject data;
    @JsonProperty("key_props")
    private Map<String, String> keyProps;
    private Map<java.lang.String, Object> additionalProperties = new HashMap<java.lang.String, Object>();

    @JsonProperty("guid")
    public java.lang.String getGuid() {
        return guid;
    }

    @JsonProperty("guid")
    public void setGuid(java.lang.String guid) {
        this.guid = guid;
    }

    public ObjectData withGuid(java.lang.String guid) {
        this.guid = guid;
        return this;
    }

    @JsonProperty("parent_guid")
    public java.lang.String getParentGuid() {
        return parentGuid;
    }

    @JsonProperty("parent_guid")
    public void setParentGuid(java.lang.String parentGuid) {
        this.parentGuid = parentGuid;
    }

    public ObjectData withParentGuid(java.lang.String parentGuid) {
        this.parentGuid = parentGuid;
        return this;
    }

    @JsonProperty("object_name")
    public java.lang.String getObjectName() {
        return objectName;
    }

    @JsonProperty("object_name")
    public void setObjectName(java.lang.String objectName) {
        this.objectName = objectName;
    }

    public ObjectData withObjectName(java.lang.String objectName) {
        this.objectName = objectName;
        return this;
    }

    @JsonProperty("timestamp")
    public Long getTimestamp() {
        return timestamp;
    }

    @JsonProperty("timestamp")
    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public ObjectData withTimestamp(Long timestamp) {
        this.timestamp = timestamp;
        return this;
    }

    @JsonProperty("parent_data")
    public UObject getParentData() {
        return parentData;
    }

    @JsonProperty("parent_data")
    public void setParentData(UObject parentData) {
        this.parentData = parentData;
    }

    public ObjectData withParentData(UObject parentData) {
        this.parentData = parentData;
        return this;
    }

    @JsonProperty("data")
    public UObject getData() {
        return data;
    }

    @JsonProperty("data")
    public void setData(UObject data) {
        this.data = data;
    }

    public ObjectData withData(UObject data) {
        this.data = data;
        return this;
    }

    @JsonProperty("key_props")
    public Map<String, String> getKeyProps() {
        return keyProps;
    }

    @JsonProperty("key_props")
    public void setKeyProps(Map<String, String> keyProps) {
        this.keyProps = keyProps;
    }

    public ObjectData withKeyProps(Map<String, String> keyProps) {
        this.keyProps = keyProps;
        return this;
    }

    @JsonAnyGetter
    public Map<java.lang.String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(java.lang.String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public java.lang.String toString() {
        return ((((((((((((((((("ObjectData"+" [guid=")+ guid)+", parentGuid=")+ parentGuid)+", objectName=")+ objectName)+", timestamp=")+ timestamp)+", parentData=")+ parentData)+", data=")+ data)+", keyProps=")+ keyProps)+", additionalProperties=")+ additionalProperties)+"]");
    }

}

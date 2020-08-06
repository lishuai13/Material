package entity;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Material {

    private Integer itemId;     //ID
    private String itemCode;    //编码
    private String itemUom;    //单位
    @NotNull(message = "物料描述不能为空")
    @Size(min =4,message = "物料描述长度必须不能少于4个字符")
    private String itemDescription; //描述
    @Nullable
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startActiveDate;   //生效时间
    @Nullable
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endActiveDate;     //失效时间
    private Integer enabledFlag;    //启用标识
    private Integer objectVersionNumber;    //版本号
    private Date creationDate;
    private Integer createBy;
    private Integer lastUpdatedBy;
    private Date lastUpdateDate;


    public Material() {
    }

    public Material(Integer itemId, String itemCode, String itemUom, String itemDescription, Date startActiveDate, Date endActiveDate, Integer enabledFlag, Integer objectVersionNumber, Date creationDate, Integer createBy, Integer lastUpdatedBy, Date lastUpdateDate) {
        this.itemId = itemId;
        this.itemCode = itemCode;
        this.itemUom = itemUom;
        this.itemDescription = itemDescription;
        this.startActiveDate = startActiveDate;
        this.endActiveDate = endActiveDate;
        this.enabledFlag = enabledFlag;
        this.objectVersionNumber = objectVersionNumber;
        this.creationDate = creationDate;
        this.createBy = createBy;
        this.lastUpdatedBy = lastUpdatedBy;
        this.lastUpdateDate = lastUpdateDate;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getItemUom() {
        return itemUom;
    }

    public void setItemUom(String itemUom) {
        this.itemUom = itemUom;
    }

    public String getItemDescription() {
        return itemDescription;
    }

    public void setItemDescription(String itemDescription) {
        this.itemDescription = itemDescription;
    }

    public String getStartActiveDate() {
        SimpleDateFormat ft = new SimpleDateFormat("yyyy/MM/dd");

        return startActiveDate==null?"未指定时间": ft.format(startActiveDate);
    }

    public void setStartActiveDate(Date startActiveDate) {
        this.startActiveDate = startActiveDate;
    }

    public String getEndActiveDate() {
        SimpleDateFormat ft = new SimpleDateFormat("yyyy/MM/dd");
        return endActiveDate==null?"未指定时间": ft.format(endActiveDate);
    }

    public void setEndActiveDate(Date endActiveDate) {
        this.endActiveDate = endActiveDate;
    }

    public Integer getEnabledFlag() {
        return enabledFlag;
    }

    public void setEnabledFlag(Integer enabledFlag) {
        this.enabledFlag = enabledFlag;
    }

    public Integer getObjectVersionNumber() {
        return objectVersionNumber;
    }

    public void setObjectVersionNumber(Integer objectVersionNumber) {
        this.objectVersionNumber = objectVersionNumber;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Integer getLastUpdatedBy() {
        return lastUpdatedBy;
    }

    public void setLastUpdatedBy(Integer lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
    }

    public Date getLastUpdateDate() {
        return lastUpdateDate;
    }

    public void setLastUpdateDate(Date lastUpdateDate) {
        this.lastUpdateDate = lastUpdateDate;
    }

    @Override
    public String toString() {
        return "Material{" +
                "itemId=" + itemId +
                ", itemCode='" + itemCode + '\'' +
                ", itemUom='" + itemUom + '\'' +
                ", itemDescription='" + itemDescription + '\'' +
                ", startActiveDate=" + startActiveDate +
                ", endActiveDate=" + endActiveDate +
                ", enabledFlag=" + enabledFlag +
                ", objectVersionNumber=" + objectVersionNumber +
                ", creationDate=" + creationDate +
                ", createBy=" + createBy +
                ", lastUpdatedBy=" + lastUpdatedBy +
                ", lastUpdateDate=" + lastUpdateDate +
                '}';
    }
}

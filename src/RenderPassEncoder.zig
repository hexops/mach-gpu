const QuerySet = @import("QuerySet.zig");
const RenderPassColorAttachment = @import("structs.zig").RenderPassColorAttachment;
const RenderPassDepthStencilAttachment = @import("structs.zig").RenderPassDepthStencilAttachment;
const RenderPassTimestampWrite = @import("structs.zig").RenderPassTimestampWrite;
const RenderPipeline = @import("RenderPipeline.zig");
const Buffer = @import("Buffer.zig");
const RenderBundle = @import("RenderBundle.zig");
const BindGroup = @import("BindGroup.zig");

const RenderPassEncoder = @This();

/// The type erased pointer to the RenderPassEncoder implementation
/// Equal to c.WGPURenderPassEncoder for NativeInstance.
ptr: *anyopaque,
vtable: *const VTable,

pub const VTable = struct {
    reference: fn (ptr: *anyopaque) void,
    release: fn (ptr: *anyopaque) void,
    draw: fn (ptr: *anyopaque, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) void,
    drawIndexed: fn (
        ptr: *anyopaque,
        index_count: u32,
        instance_count: u32,
        first_index: u32,
        base_vertex: i32,
        first_instance: u32,
    ) void,
    drawIndexedIndirect: fn (ptr: *anyopaque, indirect_buffer: Buffer, indirect_offset: u64) void,
    drawIndirect: fn (ptr: *anyopaque, indirect_buffer: Buffer, indirect_offset: u64) void,
    beginOcclusionQuery: fn (ptr: *anyopaque, query_index: u32) void,
    endOcclusionQuery: fn (ptr: *anyopaque) void,
    end: fn (ptr: *anyopaque) void,
    executeBundles: fn (ptr: *anyopaque, bundles: []RenderBundle) void,
    insertDebugMarker: fn (ptr: *anyopaque, marker_label: [*:0]const u8) void,
    popDebugGroup: fn (ptr: *anyopaque) void,
    pushDebugGroup: fn (ptr: *anyopaque, group_label: [*:0]const u8) void,
    setBindGroup: fn (ptr: *anyopaque, group_index: u32, group: BindGroup, dynamic_offsets: []u32) void,
    // WGPU_EXPORT void wgpuRenderPassEncoderSetBlendConstant(WGPURenderPassEncoder renderPassEncoder, WGPUColor const * color);
    // WGPU_EXPORT void wgpuRenderPassEncoderSetIndexBuffer(WGPURenderPassEncoder renderPassEncoder, WGPUBuffer buffer, WGPUIndexFormat format, uint64_t offset, uint64_t size);
    setLabel: fn (ptr: *anyopaque, label: [:0]const u8) void,
    setPipeline: fn (ptr: *anyopaque, pipeline: RenderPipeline) void,
    // WGPU_EXPORT void wgpuRenderPassEncoderSetScissorRect(WGPURenderPassEncoder renderPassEncoder, uint32_t x, uint32_t y, uint32_t width, uint32_t height);
    // WGPU_EXPORT void wgpuRenderPassEncoderSetStencilReference(WGPURenderPassEncoder renderPassEncoder, uint32_t reference);
    // WGPU_EXPORT void wgpuRenderPassEncoderSetVertexBuffer(WGPURenderPassEncoder renderPassEncoder, uint32_t slot, WGPUBuffer buffer, uint64_t offset, uint64_t size);
    // WGPU_EXPORT void wgpuRenderPassEncoderSetViewport(WGPURenderPassEncoder renderPassEncoder, float x, float y, float width, float height, float minDepth, float maxDepth);
    // WGPU_EXPORT void wgpuRenderPassEncoderWriteTimestamp(WGPURenderPassEncoder renderPassEncoder, WGPUQuerySet querySet, uint32_t queryIndex);
};

pub inline fn reference(pass: RenderPassEncoder) void {
    pass.vtable.reference(pass.ptr);
}

pub inline fn release(pass: RenderPassEncoder) void {
    pass.vtable.release(pass.ptr);
}

pub inline fn draw(
    pass: RenderPassEncoder,
    vertex_count: u32,
    instance_count: u32,
    first_vertex: u32,
    first_instance: u32,
) void {
    pass.vtable.draw(pass.ptr, vertex_count, instance_count, first_vertex, first_instance);
}

pub inline fn drawIndexed(
    pass: RenderPassEncoder,
    index_count: u32,
    instance_count: u32,
    first_index: u32,
    base_vertex: i32,
    first_instance: u32,
) void {
    pass.vtable.drawIndexed(pass.ptr, index_count, instance_count, first_index, base_vertex, first_instance);
}

pub inline fn drawIndexedIndirect(pass: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64) void {
    pass.vtable.drawIndexedIndirect(pass.ptr, indirect_buffer, indirect_offset);
}

pub inline fn drawIndirect(pass: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64) void {
    pass.vtable.drawIndirect(pass.ptr, indirect_buffer, indirect_offset);
}

pub inline fn beginOcclusionQuery(pass: RenderPassEncoder, query_index: u32) void {
    pass.vtable.beginOcclusionQuery(pass.ptr, query_index);
}

pub inline fn endOcclusionQuery(pass: RenderPassEncoder) void {
    pass.vtable.endOcclusionQuery(pass.ptr);
}

pub inline fn end(pass: RenderPassEncoder) void {
    pass.vtable.end(pass.ptr);
}

pub inline fn executeBundles(pass: RenderPassEncoder, bundles: []RenderBundle) void {
    pass.vtable.executeBundles(pass.ptr, bundles);
}

pub inline fn insertDebugMarker(pass: RenderPassEncoder, marker_label: [*:0]const u8) void {
    pass.vtable.insertDebugMarker(pass.ptr, marker_label);
}

pub inline fn popDebugGroup(pass: RenderPassEncoder) void {
    pass.vtable.popDebugGroup(pass.ptr);
}

pub inline fn pushDebugGroup(pass: RenderPassEncoder, group_label: [*:0]const u8) void {
    pass.vtable.pushDebugGroup(pass.ptr, group_label);
}

pub inline fn setBindGroup(
    pass: RenderPassEncoder,
    group_index: u32,
    group: BindGroup,
    dynamic_offsets: []u32,
) void {
    pass.vtable.setBindGroup(pass.ptr, group_index, group, dynamic_offsets);
}

pub inline fn setLabel(pass: RenderPassEncoder, label: [:0]const u8) void {
    pass.vtable.setLabel(pass.ptr, label);
}

pub inline fn setPipeline(pass: RenderPassEncoder, pipeline: RenderPipeline) void {
    pass.vtable.setPipeline(pass.ptr, pipeline);
}

pub const Descriptor = struct {
    label: ?[*:0]const u8 = null,
    color_attachments: []const RenderPassColorAttachment,
    depth_stencil_attachment: ?*const RenderPassDepthStencilAttachment,
    occlusion_query_set: ?QuerySet = null,
    timestamp_writes: ?[]RenderPassTimestampWrite = null,
};

test {
    _ = VTable;
    _ = reference;
    _ = release;
    _ = draw;
    _ = drawIndexed;
    _ = drawIndexedIndirect;
    _ = drawIndirect;
    _ = beginOcclusionQuery;
    _ = endOcclusionQuery;
    _ = end;
    _ = executeBundles;
    _ = insertDebugMarker;
    _ = popDebugGroup;
    _ = pushDebugGroup;
    _ = setBindGroup;
    _ = setLabel;
    _ = setPipeline;
    _ = Descriptor;
}

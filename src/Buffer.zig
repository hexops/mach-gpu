const Buffer = @This();

/// The type erased pointer to the Buffer implementation
/// Equal to c.WGPUBuffer for NativeInstance.
ptr: *anyopaque,
vtable: *const VTable,

pub const VTable = struct {
    reference: fn (ptr: *anyopaque) void,
    release: fn (ptr: *anyopaque) void,
    // TODO:
    // WGPU_EXPORT void wgpuBufferDestroy(WGPUBuffer buffer);
    // WGPU_EXPORT void const * wgpuBufferGetConstMappedRange(WGPUBuffer buffer, size_t offset, size_t size);
    // WGPU_EXPORT void * wgpuBufferGetMappedRange(WGPUBuffer buffer, size_t offset, size_t size);
    // WGPU_EXPORT void wgpuBufferMapAsync(WGPUBuffer buffer, WGPUMapModeFlags mode, size_t offset, size_t size, WGPUBufferMapCallback callback, void * userdata);
    // WGPU_EXPORT void wgpuBufferSetLabel(WGPUBuffer buffer, char const * label);
    // WGPU_EXPORT void wgpuBufferUnmap(WGPUBuffer buffer);
};

pub inline fn reference(buffer: Buffer) void {
    buffer.vtable.reference(buffer.ptr);
}

pub inline fn release(buffer: Buffer) void {
    buffer.vtable.release(buffer.ptr);
}

test "syntax" {
    _ = VTable;
    _ = reference;
    _ = release;
}
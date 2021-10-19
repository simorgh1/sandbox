# import array as arr
# nums = arr.array('i', [0, 0, 1, 1, 1, 2, 2, 3, 3, 4])

# A sorted array with duplicated elements will be cleaned up and printed to the stdout using place-in algorithm

nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]

print("Sorted array: {sortedarray}".format(sortedarray=nums))

idx=0
for item in nums[1:]:
    if item!= nums[idx]:
        idx += 1
        nums[idx] = nums[nums.index(item)]
        
print("Cleanedup array: {sortedarray}, length: {arraylength}".format(sortedarray=nums[:idx+1], arraylength=idx))
